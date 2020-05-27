
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


##
## hooking in other apps…
##

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


source $(brew --prefix nvm)/nvm.sh

##
## Completion…
##

if [[ -n "$ZSH_VERSION" ]]; then  # quit now if in zsh
    return 1 2> /dev/null || exit 1;
fi;




# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;


# bash completion.
if  which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    #source "$(brew --prefix)/share/bash-completion/bash_completion";
    source "$(brew --prefix)/etc/bash_completion.d/brew"
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
elif which brew > /dev/null && [ -f "$(brew --repository)/Library/Contributions/brew_bash_completion.sh" ]; then
    source `brew --repository`/Library/Contributions/brew_bash_completion.sh;
fi;


# homebrew completion
# if  which brew > /dev/null; then
#    # source `brew --repository`/Library/Contributions/brew_bash_completion.sh
#    source "$(brew --prefix)/etc/bash_completion.d/brew"
#     [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# if  which brew > /dev/null; then
    
# fi;

#[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
. /usr/local/etc/bash_completion.d/git-completion.bash;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
    source /usr/local/etc/bash_completion.d/git-completion.bash;
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

eval "$(direnv hook bash)"

##
## better `cd`'ing
##

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;


ssh-add -K ~/.ssh/id_rsa &> /dev/null;


#source $(brew --prefix nvm)/nvm.sh

fortune | cowsay

