#!/bin/bash

LOCAL_PATH=$(pwd)

function install_zsh {

	echo "Installing zsh...";

	rm -f $HOME/.zshrc
	rm -rf $HOME/.oh-my-zsh
	ln -s $LOCAL_PATH/zsh/zshrc $HOME/.zshrc
	ln -s $LOCAL_PATH/oh-my-zsh $HOME/.oh-my-zsh
	chsh -s /bin/zsh
}
function install_git {

	echo "Installing git...";

	rm -f $HOME/.gitconfig
	ln -s $LOCAL_PATH/git/gitconfig $HOME/.gitconfig
}
function install_vim {

	echo "Installing vim...";

	rm -f $HOME/.vimrc
	rm -rf $HOME/.vim
	ln -s $LOCAL_PATH/vim/vimrc $HOME/.vimrc
	ln -s $LOCAL_PATH/vim/vim $HOME/.vim
}
function install_xmonad_laptop {

	echo "Installing xmobar for laptop...";

	sudo rm -f /usr/bin/xmo-battery
	sudo ln -s $LOCAL_PATH/tools/xmo-battery /usr/bin/xmo-battery
	
	rm -f $HOME/.xmobarrc
	ln -s $LOCAL_PATH/xmonad/xmobarrc.laptop $HOME/.xmobarrc
}
function install_xmonad_desktop {

	echo "Installing xmobar for desktop...";

	rm -f $HOME/.xmobarrc
	ln -s $LOCAL_PATH/xmonad/xmobarrc.desktop $HOME/.xmobarrc
}
function install_xmonad_common {
	
	echo "Installing xmonad...";

	sudo rm -f /usr/share/xsessions/xmonad.desktop
	sudo rm -f /bin/xmonad-startup
	
	mkdir -p $HOME/.xmonad
	rm -f $HOME/.xmonad/xmonad.hs
	
	ln -s $LOCAL_PATH/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
	sudo ln -s $LOCAL_PATH/xmonad/xmonad.desktop /usr/share/xsessions/xmonad.desktop
	sudo ln -s $LOCAL_PATH/xmonad/xmonad-startup /bin/xmonad-startup
}
function install_xmonad_common_withbg {
	install_xmonad_common

	rm -f $HOME/.xmonad_background.jpg
	ln -s $LOCAL_PATH/xmonad/background.jpg $HOME/.xmonad_background.jpg
	
	sudo rm -f /bin/xmonad-startup
	sudo ln -s $LOCAL_PATH/xmonad/xmonad-startup /bin/xmonad-startup-common
	sudo ln -s $LOCAL_PATH/xmonad/xmonad-startup-bg /bin/xmonad-startup
}

LAPTOP=false
DESKTOP=false

XMONAD=false
XMOBG=false
VIM=false
GIT=false
ZSH=false

ALL=false

while getopts ldaxbvgz option
do
        case "${option}"
        in
                l) LAPTOP=true;;
                d) DESKTOP=true;;
                a) ALL=true;;
				x) XMONAD=true;;
				b) XMOBG=true;;
				v) VIM=true;;
				g) GIT=true;;
				z) ZSH=true;;
        esac
done

if ($ALL); then
	XMONAD=true;
	VIM=true;
	GIT=true;
	ZSH=true;
fi

if ($XMOBG); then
	echo "NO BG FFS!!";
fi

if ($LAPTOP && $DESKTOP); then
	echo "You can't install both the laptop and desktop version!";
elif (!($LAPTOP) && !($DESKTOP)); then
	echo "You must install either the laptop or desktop version!";
else
	if ($XMONAD); then
		install_xmonad_common;
		if ($LAPTOP); then
			install_xmonad_laptop;
		elif ($DESKTOP); then
			install_xmonad_desktop;
		fi
	fi
	if ($VIM); then
		install_vim;
	fi
	if ($GIT); then
		install_git;
	fi
	if ($ZSH); then
		install_zsh;
	fi

	if ($XMOBG); then
		install_xmonad_common_withbg
	fi

	echo "Done!"
fi


