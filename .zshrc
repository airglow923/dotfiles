# zmodload zsh/zprof

export EDITOR="nvim"
export GPG_TTY=$TTY

source ~/.keychain/"$(hostname)-sh"
source ~/.keychain/"$(hostname)-sh-gpg"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

autoload -Uz compaudit compinit

[ ! "$(find ~/.zcompdump -mtime +1)" ] && compinit -C || compinit

export NVM_LAZY_LOAD=true

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(evalcache zsh-syntax-highlighting npm git gitfast zsh-nvm)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

unalias -m '*'

# Hyundeok Park's aliases
alias ls='ls --color=auto'
alias cbuild='cmake --build . -j $((`nproc` + 1))'
alias git-verbose='GIT_TRACE=1 GIT_CURL_VERSION=1 GIT_SSH_COMMAND="ssh -vvv" git'
alias callgrind='valgrind --tool=callgrind'
alias grep='grep --color=auto'
alias s='ssh'
alias n='nvim'
alias t='tmux'
alias curl-safe='curl -sSf --tlsv1.2 --proto '\''=https'\'''
alias rcopy='rsync -a --append-verify'
alias gradlew='JAVA_HOME=/root/.sdkman/candidates/java/current bash ./gradlew'

# enable glob syntax
setopt extended_glob

# print error if pattern not found
setopt nomatch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# disable directory highlighting on WSL
export LS_COLORS=$LS_COLORS"ow=1;34:"

# syntax highlighting for less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Android related environment variablees
export ANDROID_HOME="$HOME/android/sdk"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/26.2.11394342"
export NDK_TOOLCHAIN_DIR="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin"
export AR_aarch64_linux_android="$NDK_TOOLCHAIN_DIR/llvm-ar"
export AR_armv7_linux_androideabi="$NDK_TOOLCHAIN_DIR/llvm-ar"
export AR_x86_64_linux_android="$NDK_TOOLCHAIN_DIR/llvm-ar"
export AR_i686_linux_android="$NDK_TOOLCHAIN_DIR/llvm-ar"
export CC_aarch64_linux_android="$NDK_TOOLCHAIN_DIR/aarch64-linux-android26-clang"
export CC_armv7_linux_androideabi="$NDK_TOOLCHAIN_DIR/armv7a-linux-androideabi26-clang"
export CC_x86_64_linux_android="$NDK_TOOLCHAIN_DIR/x86_64-linux-android26-clang"
export CC_i686_linux_android="$NDK_TOOLCHAIN_DIR/i686-linux-android26-clang"
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER="$NDK_TOOLCHAIN_DIR/aarch64-linux-android26-clang"
export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER="$NDK_TOOLCHAIN_DIR/armv7a-linux-androideabi26-clang"
export CARGO_TARGET_I686_LINUX_ANDROID_LINKER="$NDK_TOOLCHAIN_DIR/i686-linux-android26-clang"
export CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER="$NDK_TOOLCHAIN_DIR/x86_64-linux-android26-clang"
export GRADLE_USER_HOME="$HOME/.gradle"

for appimage in ~/appimage/*.appimage; do
	alias "$(awk -F "." '{print $1}' <<<"$(basename "$appimage")")"="$appimage"
done

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"

# add npm global to PATH
export PATH="$HOME/.npm-global/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# wasm
export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

# Flutter
export PATH="$PATH:$HOME/.local/flutter/bin"

# Vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"

# Go
export PATH="$PATH:$HOME/go/bin"

export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

. "$HOME/.cargo/env"

export HISTSIZE=99999999
export SAVEHIST=99999999

[ "$TMUX" != "" ] && export TERM="xterm-256color"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# zprof
