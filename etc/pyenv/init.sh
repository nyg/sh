export PYENV_ROOT="$HOME/.config/pyenv"
export PYENV_SHELL=$(basename $SHELL)

# On macOS pyenv is installed via brew so its binaries are already in the path.
command -v pyenv > /dev/null || { [ "$(uname)" != Darwin ] && PATH="$PATH:$PYENV_ROOT/bin"; }
command -v pyenv > /dev/null || PATH="$PYENV_ROOT/shims:$PATH"

pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")"
    ;;
  *)
    command pyenv "$command" "$@"
    ;;
  esac
}
