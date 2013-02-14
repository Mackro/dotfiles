
LOCAL_PATH = $(shell pwd)

prepare:
	sudo apt-get install feh
	sudo apt-get install vim
	sudo apt-get acpi

install:

	# Bash
	rm -f $(HOME)/.bashrc
	rm -f $(HOME)/.bash_aliases
	rm -f $(HOME)/.bash_env
	rm -f $(HOME)/.bash_prompt

	ln -s $(LOCAL_PATH)/bash/bashrc $(HOME)/.bashrc
	ln -s $(LOCAL_PATH)/bash/bash_aliases $(HOME)/.bash_aliases
	ln -s $(LOCAL_PATH)/bash/bash_env $(HOME)/.bash_env
	ln -s $(LOCAL_PATH)/bash/bash_prompt $(HOME)/.bash_prompt


	# Git
	rm -f $(HOME)/.gitconfig
	
	ln -s $(LOCAL_PATH)/git/gitconfig $(HOME)/.gitconfig


	# Vim
	rm -f $(HOME)/.vimrc

	ln -s $(LOCAL_PATH)/vim/vimrc $(HOME)/.vimrc

	# Xmonad
	rm -f $(HOME)/.xmonad_background.jpg
	sudo rm -f /usr/share/xsessions/xmonad.desktop

	ln -s $(LOCAL_PATH)/xmonad/background.jpg $(HOME)/.xmonad_background.jpg
	sudo ln -s $(LOCAL_PATH)/xmonad/xmonad.desktop /usr/share/xsessions/xmonad.desktop
	sudo ln -s $(LOCAL_PATH)/xmonad/xmonad-startup /bin/xmonad-startup

uninstall:

	rm -f /usr/share/xsessions/xmonad.desktop
	cp $(LOCAL_PATH)/xmonad/xmonad.desktop.default
	
