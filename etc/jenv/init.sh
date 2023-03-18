SHELLNAME=$(basename $SHELL)

export JENV_ROOT="$HOME/.config/jenv"
export JENV_SHELL=$SHELLNAME
export JENV_LOADED=1

# On macOS jenv is installed via brew so its binaries are already in the path.
command -v jenv > /dev/null || { [ "$(uname)" != Darwin ] && PATH="$PATH:$JENV_ROOT/bin" }
command -v jenv > /dev/null || PATH="$JENV_ROOT/shims:$PATH"

unset JAVA_HOME
unset JDK_HOME

source "$JENV_ROOT/plugins/export/etc/jenv.d/init/export_jenv_hook.$SHELLNAME"

jenv() {
  type typeset &> /dev/null && typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}

# if typeset -f zsh-defer > /dev/null
# then
#     zsh-defer eval "$(jenv init -)"
# else
#     eval "$(jenv init -)"
# fi
