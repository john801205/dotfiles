eval "$(/opt/homebrew/bin/brew shellenv)"

export VISUAL=nvim
export EDITOR=${VISUAL}
export LANG=en_US.UTF-8

export JAVA_HOME="$(/usr/libexec/java_home)"

. "$HOME/.cargo/env"

# >>> coursier install directory >>>
# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"$HOME/Library/Application Support/Coursier/bin":*)
        ;;
    *)
        export PATH="$HOME/Library/Application Support/Coursier/bin:$PATH"
        ;;
esac
# <<< coursier install directory <<<
