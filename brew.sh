#!/bin/bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade


# GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names


# Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash
# regular bash-completion package is held back to an older release, so we get latest from versions.
#   github.com/Homebrew/homebrew/blob/master/Library/Formula/bash-completion.rb#L3-L4
#brew tap homebrew/versions ///Removed, now in core no need to tap
brew install bash-completion2

brew install brew-cask-completion

# generic colouriser  http://kassiopeia.juls.savba.sk/~garabik/software/grc/
brew install grc

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some OS X tools
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen


# run this script when this file changes guy.
brew install entr

# github util. imho better than hub
brew install gh


# mtr - ping & traceroute. best.
brew install mtr

# allow mtr to run without sudo
mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/paulirish/.homebrew/Cellar/mtr/0.86`
sudo chmod 4755 $mtrlocation/sbin/mtr
sudo chown root $mtrlocation/sbin/mtr


# Install other useful binaries
brew install ack
brew install android-platform-tools
brew install ffmpeg --with-libvpx
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install node # This installs `npm` too using the recommended installation method
brew install pidcat   # colored logcat guy
brew install pv
brew install rename
brew install sift
brew install speedtest_cli
brew install ssh-copy-id
brew install terminal-notifier
brew install todo-txt
brew install timewarrior
brew install tree
brew install webkit2png
brew install zopfli
brew install zsh


# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
#brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
# brew install knock
# brew install netpbm
#brew install nmap
#brew install pngcheck
#brew install socat
brew install sqlmap
# brew install tcpflow
# brew install tcpreplay
# brew install tcptrace
#brew install ucspi-tcp # `tcpserver` etc.
#brew install xpdf
#brew install xz


brew install cowsay

brew install fortune

brew install ansiweather

brew install yarn

# Compress .xz Files
brew install xz

# Terminal coloring or something
brew install vte

#Convenient man page spark notes
brew install tldr

brew install tidy-html5

brew install tcpdump

brew install sl

brew install speedtest-cli

brew install python
brew install python3

brew install perl

brew install ruby

brew install sphinx-doc

brew install readline

brew install nvm

brew install openssl

brew install oniguruma

brew install jq

brew install htop

brew install dark-mode

brew install curl

brew install glib

brew install gcc

brew install calc

brew install autoconf

brew install automake

# Needed for ZSH
brew install antigen


# Remove outdated versions from the cellar
brew cleanup
brew install fzf
