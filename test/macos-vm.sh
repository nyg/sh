#!/usr/bin/env sh

set -eu

usage()
{
    echo "Usage: $0 [-f brew-formulae.txt] [-c brew-casks.txt] [-s disk-size-gb] [-k] [base-vm]" >&2
    exit 1
}

formulae=
casks=
disk_size=100
keep=0

while getopts f:c:s:k opt
do
    case $opt in
        f) formulae=$(realpath "$OPTARG") ;;
        c) casks=$(realpath "$OPTARG") ;;
        s) disk_size=$OPTARG ;;
        k) keep=1 ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))
[ $# -le 1 ] || usage

base=${1:-mac27}
repo_dir=$(cd "$(dirname "$0")/.." && pwd)
vm=sh-test-$(date +%Y%m%d-%H%M%S)
log_dir="$repo_dir/test/logs/$vm"
work_dir=$(mktemp -d /tmp/sh-test.XXXXXX)
ip=
passed=0
failed=0

mkdir -p "$log_dir"

# Cirrus Labs images have an admin user whose password is admin.
printf '#!/bin/sh\necho admin\n' > "$work_dir/askpass"
chmod +x "$work_dir/askpass"

vm_ssh()
{
    SSH_ASKPASS="$work_dir/askpass" SSH_ASKPASS_REQUIRE=force ssh \
        -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o LogLevel=ERROR \
        -o PubkeyAuthentication=no \
        -o ConnectTimeout=5 \
        -o ServerAliveInterval=30 \
        -o ControlMaster=auto \
        -o ControlPath="$work_dir/ssh.sock" \
        -o ControlPersist=yes \
        "admin@$ip" "$@"
}

cleanup()
{
    [ -n "$ip" ] && vm_ssh -O exit >/dev/null 2>&1 || true

    if [ $keep -eq 1 ]
    then
        echo "VM $vm kept running: ssh admin@$ip (password admin)"
        echo "Remove it with: tart stop $vm && tart delete $vm"
    else
        tart stop "$vm" >/dev/null 2>&1 || true
        tart delete "$vm" >/dev/null 2>&1 || true
    fi

    rm -rf "$work_dir"
}

trap cleanup EXIT
trap 'exit 130' INT TERM

step()
{
    name=$1
    command=$2
    input=${3:-/dev/null}
    log="$log_dir/$(printf '%02d' $((passed + failed + 1)))-$(echo "$name" | tr ' /' '--').log"
    start=$(date +%s)

    printf '%-24s ' "$name"
    if vm_ssh "$command" < "$input" > "$log" 2>&1
    then
        passed=$((passed + 1))
        echo "ok ($(($(date +%s) - start))s)"
    else
        failed=$((failed + 1))
        echo "FAILED ($(($(date +%s) - start))s), see $log"
        tail -n 5 "$log" | sed 's/^/    /'
    fi
}

# Each step runs in a new login zsh, so it sees what previous steps added to the profile.
in_login_shell()
{
    echo "cd \"\$HOME/.\$USER-sh\" 2>/dev/null; NONINTERACTIVE=1 zsh -lc '$1'"
}

echo "Cloning $base into ${vm}…"
tart clone "$base" "$vm"
tart set "$vm" --disk-size "$disk_size"

echo Booting…
tart run --no-graphics "$vm" > "$log_dir/tart-run.log" 2>&1 &
ip=$(tart ip --wait 180 "$vm")

echo "Waiting for SSH on ${ip}…"
tries=0
until vm_ssh true < /dev/null 2>/dev/null
do
    tries=$((tries + 1))
    if [ $tries -ge 60 ]
    then
        echo "Could not connect to $ip, check that your terminal has the Local Network permission" >&2
        exit 1
    fi
    sleep 2
done

echo Copying checkout to the VM…
tar -C "$repo_dir" --exclude .git --exclude softwares --exclude test/logs --exclude .DS_Store -cf - . \
    | vm_ssh 'rm -rf /tmp/sh && mkdir /tmp/sh && tar -C /tmp/sh -xf -'
[ -n "$formulae" ] && vm_ssh 'cat > /tmp/brew-formulae.txt' < "$formulae"
[ -n "$casks" ] && vm_ssh 'cat > /tmp/brew-casks.txt' < "$casks"
printf 'Test User\ntest@example.com\n' > "$work_dir/git-answers"

echo "Running steps, logs in $log_dir"
step bootstrap.sh "$(in_login_shell 'sh /tmp/sh/bootstrap.sh')"
step "copy checkout" 'mkdir -p "$HOME/.$USER-sh" && cp -R /tmp/sh/. "$HOME/.$USER-sh/"'

for script in configure/xdg.sh \
              configure/brew.sh \
              configure/zsh.sh \
              install/zsh-p10k.sh \
              install/zsh-defer.sh \
              configure/brew-cron.sh \
              configure/ssh-client.sh \
              configure/git.sh \
              configure/vim.sh \
              configure/colima.sh \
              install/pyenv.sh \
              install/jenv.sh \
              install/nvm.sh \
              install/mvnd.sh \
              install/visualvm.sh \
              install/gpg.sh \
              install/mariadb.sh
do
    input=/dev/null
    [ "$script" = configure/git.sh ] && input="$work_dir/git-answers"
    step "$script" "$(in_login_shell "./$script")" "$input"
done

[ -n "$formulae" ] && step "brew formulae" "$(in_login_shell 'sh test/brew-replay.sh formula /tmp/brew-formulae.txt')"
[ -n "$casks" ] && step "brew casks" "$(in_login_shell 'sh test/brew-replay.sh cask /tmp/brew-casks.txt')"
step "shell check" "$(in_login_shell 'sh test/check-shell.sh')"

echo
echo "$passed passed, $failed failed, logs in $log_dir"
[ $failed -eq 0 ]
