# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$(yarn global bin):$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export GITHUB_USER=mkykode@gmail.com
export GITHUB_PASSWORD=flex.beer.gasoline.clue
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node npm zsh-syntax-highlighting osx extract vscode zsh-autosuggestions wp-cli)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /Users/jullweber/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. ~/z.sh
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
alias t="terminus"
alias tlogin="terminus auth:login --email jull@monkeykodeagency.com"
alias trwp="terminus remote:wp --"
alias tcache="terminus env:clear-cache"
alias tcs="terminus connection:set"
alias tec="terminus env:commit --message"
alias lnd="lando"
alias lndoff="lando poweroff"
alias lndrb="lando rebuild -y"
alias lndrs="lando restart"
alias lndd="lando destroy"
alias lndi="lando info"
alias lndst="lando start"
alias lndstp="lando stop"
alias lpl="lando pull"
alias lp="lando push"
alias lwp="lando wp"
alias lwppa="lando wp plugin activate"
alias lwppd="lando wp plugin deactivate"
alias lwppi="lando wp plugin install"
alias lwppu="lando wp plugin uninstall"
alias lwppua="lando wp plugin update --all"
alias lwptua="lando wp theme update --all"
alias lwppl="lando wp plugin list"
alias y="yarn"
alias ys="yarn start"
alias ya="yarn add"
alias yd="yarn dev"
alias yb="yarn build"
alias yp="yarn prod"
alias ybp="yarn build:production"
alias yw="yarn watch"
alias yr="yarn remove"
alias yi="yarn init -y"
alias git="hub"
alias dnsflush="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias n="npm"
alias ns="npm start"
alias ninit="npm init"
alias nr="npm run"
alias nb="npm run build"
alias ni="npm install"
alias nre="npm remove"
alias nrpu="npm run packages-update "
function tdeploy() {
    terminus env:deploy --cc -- $1.test;
    terminus env:deploy --cc -- $1.live;
}

function twclonelive() {
    terminus env:clone-content --cc -y -- $1.live test;
    terminus remote:wp -- $1.test search-replace "//$2" "//test-$1.pantheonsite.io";
    terminus env:clone-content -y --cc -- $1.test dev;
    terminus remote:wp -- $1.dev search-replace "//test-$1.pantheonsite.io" "//dev-$1.pantheonsite.io";
}

function twm() {
    terminus upstream:updates:apply --accept-upstream -- $1.dev;
    terminus connection:set $1.dev sftp;
    teminus remote:wp --progress -- $1.dev plugin update --all;
    teminus remote:wp --progress -- $1.dev theme update --all;
    teminus env:commit --message "MK mainteance" -- $1.dev;
    terminus connection:set $1.dev git;
}

autoload -U promptinit; promptinit
prompt pure
