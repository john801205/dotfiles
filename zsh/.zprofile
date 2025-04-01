eval "$(/opt/homebrew/bin/brew shellenv)"

export VISUAL=nvim
export EDITOR=${VISUAL}
export LANG=en_US.UTF-8

export JAVA_HOME="$(/usr/libexec/java_home)"

# >>> coursier install directory >>>
export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
