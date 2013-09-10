#!/bin/zsh

LOCAL_PATH=$(pwd)

function install_zsh {

	echo "Installing zsh...";

	if [ -f $HOME/.zshrc ]; then
		echo "Backing up old zshrc"
		mv $HOME/.zshrc $HOME/.zshrc.BACKUP
	fi
	
	if [ ! -d $HOME/.oh-my-zsh ]; then
		. $LOCAL_PATH/installs/install-oh-my-zsh.sh
		rm -rf $HOME/.zshrc
	fi

	ln -s $LOCAL_PATH/zsh/zshrc $HOME/.zshrc
	
	touch $HOME/.aliases;
	touch $HOME/.paths;

	chsh -s /bin/zsh

	./zsh/gnome-terminal-colors-solarized/install.sh
	./zsh/gnome-terminal-colors-solarized/solarize
}
function install_git {

	echo "Installing git...";

	hash git 2>/dev/null || { sudo apt-get install git };

	if [ -f $HOME/.gitconfig ]; then
		echo "Backing up old gitconfig";
		mv $HOME/.gitconfig $HOME/.gitconfig.BACKUP
	fi

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

	install_xmonad_dependencies;

	sudo rm -f /usr/share/xsessions/xmonad.desktop
	sudo rm -f /usr/bin/xmonad-startup
	
	mkdir -p $HOME/.xmonad
	rm -f $HOME/.xmonad/xmonad.hs
	
	ln -s $LOCAL_PATH/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
	sudo ln -s $LOCAL_PATH/xmonad/xmonad.desktop /usr/share/xsessions/xmonad.desktop
	sudo ln -s $LOCAL_PATH/xmonad/xmonad-startup /usr/bin/xmonad-startup
}
function install_keymap {
	echo "Installing keymap barber...";

	rm -rf /usr/share/X11/xkb/symbols/barber

	sudo ln -s $(LOCAL_PATH)/keymap/barber /usr/share/X11/xkb/symbols/barber

}

LAPTOP=false
DESKTOP=false

XMONAD=false
VIM=false
GIT=false
ZSH=false
KEYMAP=false

ALL=false

while getopts ldaxvgzk option
do
        case "${option}"
        in
                l) LAPTOP=true;;
                d) DESKTOP=true;;
                a) ALL=true;;
				x) XMONAD=true;;
				v) VIM=true;;
				g) GIT=true;;
				z) ZSH=true;;
				k) KEYMAP=true;;
        esac
done

if ($ALL); then
	XMONAD=true;
	VIM=true;
	GIT=true;
	ZSH=true;
	KEYMAP=true;
fi

if ($LAPTOP && $DESKTOP); then
	echo "You can't install both the laptop and desktop version!";
elif ($XMONAD && !($LAPTOP) && !($DESKTOP)); then
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
	if ($KEYMAP); then
		install_keymap;
	fi

	echo "Done!"
fi

