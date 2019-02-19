
failure() {
  local lineno=$1
  echo "Failed at $lineno"
}

#trap 'failure ${LINENO}' ERR

# Load our dotfiles like ~/.bash_prompt, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# to help sublimelinter etc with finding my PATHS
case $- in
   *i*) source ~/.extra
esac


# generic colouriser
GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n "$GRC" ]
    then
        alias colourify="$GRC -es --colour=auto"
        alias configure='colourify ./configure'
        for app in {diff,make,gcc,g++,ping,traceroute}; do
            alias "$app"='colourify '$app
    done
fi

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

##
## gotta tune that bash_history…
##

# timestamps for later analysis. www.debian-administration.org/users/rossen/weblog/1
export HISTTIMEFORMAT='%F %T '

# keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
which shopt > /dev/null && shopt -s histappend  # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ^ the only downside with this is [up] on the readline will go over all history not just this bash session.



##
## hooking in other apps…
##
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"




if [ -f " ~/code/z/z.sh" ]; then
    # z beats cd most of the time.
    #   github.com/rupa/z
    source ~/code/z/z.sh
elif which brew > /dev/null && [ -f "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    # z beats cd most of the time.
    #   github.com/rupa/z
    source "$(brew --prefix)/etc/profile.d/z.sh";
fi;


##
## Completion…
##

if [[ -n "$ZSH_VERSION" ]]; then  # quit now if in zsh
    return 1 2> /dev/null || exit 1;
fi;

# bash completion.
if  which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    #source "$(brew --prefix)/share/bash-completion/bash_completion";
    source "$(brew --prefix)/etc/bash_completion.d/brew"
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;


# homebrew completion
if  which brew > /dev/null; then
   # source `brew --repository`/Library/Contributions/brew_bash_completion.sh
   source "$(brew --prefix)/etc/bash_completion.d/brew"
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &> /dev/null; then
    __git_complete g __git_main
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults


##
## better `cd`'ing
##

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# export JAVA_6_HOME=$(/usr/libexec/java_home -v1.6)
# export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)

#alias java6='export JAVA_HOME=$JAVA_6_HOME'
#alias java7='export JAVA_HOME=$JAVA_7_HOME'
alias java8='export JAVA_HOME=$JAVA_8_HOME'

#default java8
export JAVA_HOME=$JAVA_8_HOME

#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
export JAVA=$JAVA_HOME/bin
export MAVEN_COLOR=true
export M2_HOME=/opt/local/share/java/maven3
export M2=$M2_HOME/bin
export APP_ENGINE=/Users/kkrcentralit/common/appengine-java-sdk-1.9.42/bin
export J_ENV=/Users/kkrcentralit/.jenv/shims
export PLAY_FRAMEWORK=/Users/daniel/projects/play1
export RUBY_GEMS=/usr/local/lib/ruby/gems/2.6.0/bin


export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=$PATH:$M2:$JAVA:$APP_ENGINE:$J_ENV:$PLAY_FRAMEWORK:$RUBY_GEMS

export JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true"
export NVM_DIR=~/.nvm



ssh-add -K ~/.ssh/id_rsa &> /dev/null;



#source $(brew --prefix nvm)/nvm.sh


fortune | cowsay
