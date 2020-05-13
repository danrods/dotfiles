# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000
#ZSH_CACHE_DIR=/tmp

# vim bindings
bindkey -v


fpath=( "$HOME/.zfunctions" $fpath )

export ANTIGEN_LOG="/var/log/antigen/antigen.log"
export ANTIGEN_DEBUG_LOG="/var/log/antigen/debug.log"

# antigen time!
# source ~/code/antigen/antigen.zsh
#source /usr/local/share/antigen/antigen.zsh
source $(brew --prefix)/share/antigen/antigen.zsh

# load presto!
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

######################################################################
### install some antigen bundles

# local b="antigen-bundle"
#local b="antigen bundle"
# local b="antigen bundle"

# Don't load the oh-my-zsh's library. Takes too long. No need.
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
    capistrano
    cp
    emoji
    fzf
    helm
    history
    sudo
    wfxr/forgit
    $HOME/.zsh_custom/plugins/palette
    $HOME/.zsh_custom/plugins/skaffold

    # atom editor
    atom
    autojump

    # homebrew 
    brew
    brew-cask

    # Guess what to install when running an unknown command.
    command-not-found

    common-aliases

    compleat

    # Helper for extracting different types of archives.
    extract

    git
    git-extras
    git-flow

    heroku

    lein
    npm
    osx
    pip
    web-search
    z


    # ------- Git Repos -------------

    # Tracks your most used directories, based on 'frecency'.
    robbyrussell/oh-my-zsh plugins/z

    # nicoulaj's moar completion files for zsh -- not sure why disabled.
    zsh-users/zsh-completions src

    # Syntax highlighting on the readline
    zsh-users/zsh-syntax-highlighting

    # history search
    zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

    # suggestions
    tarruda/zsh-autosuggestions

    # colors for all files!
    trapd00r/zsh-syntax-highlighting-filetypes

    # dont set a theme, because pure does it all
    mafredri/zsh-async
    sindresorhus/pure

    #Auto Env (direnv)
    # kennethreitz/autoenv
    Tarrasch/zsh-autoenv #Special ZSH version

    # ---------------------------------

EOBUNDLES



#antigen theme gnzh
# antigen theme robbyrussell
# antigen theme XsErG/zsh-themes themes/lazyuser
# antigen theme agnoster
# antigen theme funky
# antigen theme githubuser/repo

# Setup zsh-autosuggestions
#source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

###
#################################################################################################


# Automatically list directory contents on `cd`.
auto-ls () {
	emulate -L zsh;
    # explicit sexy ls'ing as aliases arent honored in here.
	# explicit sexy ls'ing as aliases arent honored in here.
	hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}
chpwd_functions=( auto-ls $chpwd_functions )


# Enable autosuggestions automatically
zle-line-init() {
    zle autosuggest-fetch
}

zle-history-up(){
	bindkey "$terminfo[kcuu1]" history-substring-search-up
}

zle-history-down(){
	bindkey "$terminfo[kcud1]" history-substring-search-down
}



# bind UP and DOWN arrow keys for history search
zmodload zsh/terminfo
zle -N zle-history-up
zle -N zle-history-down

# config for suggestions
AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1

export PURE_GIT_UNTRACKED_DIRTY=0

zle -N zle-line-init



# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history


zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz promptinit
promptinit
prompt powerlevel10k


# uncomment to finish profiling
# zprof


# Tell antigen that you're done.
antigen apply

# Load default dotfiles
source ~/.bash_profile

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
