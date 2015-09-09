#!/bin/sh

apt-get -y -qq update
apt-get -y -qq install build-essential git
apt-get -y -qq install net-tools lsof #provides netstat
apt-get -y -qq install tmux psmisc #provides
apt-get -y -qq install psmisc #provides killall
apt-get -y -qq install p7zip-full #7zip
apt-get -y -qq install netcat

cd
git init
git remote rm origin 2>/dev/null
git remote add origin https://github.com/taylormonacelli/dotfiles.git
{ git fetch -p && git checkout -ft origin/master; } &

# install emacs and stow
curl -o stow-install.sh https://raw.githubusercontent.com/TaylorMonacelli/gnu-stow-install/master/install.sh
sh -x stow-install.sh
curl -o emacs-install.sh https://raw.githubusercontent.com/TaylorMonacelli/emacs_build/emacsapt/emacs-install-apt.sh
sh -x emacs-install.sh

apt-get install -y -qq htop

# fetch emacs packages through melpa
emacs --daemon

test 0 -eq $(grep -c 'echo export TERM=xterm-256color' ~/.bashrc) &&
	echo export TERM=xterm-256color >>~/.bashrc
