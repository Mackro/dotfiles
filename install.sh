#!/bin/bash

LOCAL_PATH=$(pwd)

# Groups
function all_laptop {
	all_common
	xmonad_laptop
}
function all_desktop {
	all_common
	xmonad_desktop
}
function all_common {
	zsh
	git
	vim
	tools
}

# Parts
function zsh {
	rm -f $HOME/.zshrc
	rm -rf $HOME/.oh-my-zsh
	ln -s $LOCAL_PATH/zsh/zshrc $HOME/.zshrc
	ln -s $LOCAL_PATH/oh-my-zsh $HOME/.oh-my-zsh
	chsh -s /bin/zsh
}
function git {
	rm -f $HOME/.gitconfig
	ln -s $LOCAL_PATH/git/gitconfig $HOME/.gitconfig
}
function vim {
	rm -f $HOME/.vimrc
	rm -rf $HOME/.vim
	ln -s $LOCAL_PATH/vim/vimrc $HOME/.vimrc
	ln -s $LOCAL_PATH/vim/vim $HOME/.vim
}
function tools {
	sudo rm -f /usr/bin/wvim
	sudo ln -s $LOCAL_PATH/tools/wvim /usr/bin/wvim

	sudo rm -f /usr/bin/verbose_clock
	sudo ln -s $LOCAL_PATH/tools/verbose_clock /usr/bin/verbose_clock
}
function xmonad_laptop {

	xmonad_common

	sudo rm -f /usr/bin/xmo-battery
	sudo ln -s $LOCAL_PATH/tools/xmo-battery /usr/bin/xmo-battery
	
	rm -f $HOME/.xmobarrc
	ln -s $LOCAL_PATH/xmonad/xmobarrc.laptop $HOME/.xmobarrc
}
function xmonad_desktop {

	xmonad_common
	
	rm -f $HOME/.xmobarrc
	ln -s $LOCAL_PATH/xmonad/xmobarrc.desktop $HOME/.xmobarrc
}
function xmonad_common {

	rm -f $HOME/.xmonad_background.jpg
	sudo rm -f /usr/share/xsessions/xmonad.desktop
	sudo rm -f /bin/xmonad-startup
	
	mkdir -p $HOME/.xmonad
	rm -f $HOME/.xmonad/xmonad.hs
	
	ln -s $LOCAL_PATH/xmonad/background.jpg $HOME/.xmonad_background.jpg
	ln -s $LOCAL_PATH/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
	sudo ln -s $LOCAL_PATH/xmonad/xmonad.desktop /usr/share/xsessions/xmonad.desktop
	sudo ln -s $LOCAL_PATH/xmonad/xmonad-startup /bin/xmonad-startup
}

LAPTOP=false
DESKTOP=false
ALL=false

while getopts lda option
do
        case "${option}"
        in
                l) LAPTOP=true;;
                d) DESKTOP=true;;
                a) ALL=true;;
        esac
done

if (LA) ; then
elif ( $ALL && $LAPTOP ) ; then
	all_laptop
elif ( $ALL && $DESKTOP ) ; then
	all_desktop
fi

