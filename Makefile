default:

install:

	# Make sure that all the required packages are installed

	sudo apt-get install feh vim

	# Set up the folder stucture
	
	rm -rf $(HOME)/.dotfiles

	mkdir $(HOME)/.dotfiles
	mkdir $(HOME)/.dotfiles/xmonad

	# Copy files for bash
	rm -f $(HOME)/.bashrc	
	rm -f $(HOME)/.bash_aliases	

	cp etc/warning $(HOME)/.bashrc
	cat bash/bashrc >> $(HOME)/.bashrc
	
	cp etc/warning $(HOME)/.bash_aliases
	cat bash/bash_aliases >> $(HOME)/.bash_aliases

	# Copy the gitconfig
	
	rm -f $(HOME)/.gitconfig
	cp etc/warning $(HOME)/.gitconfig
	cat git/gitconfig >> $(HOME)/.gitconfig

	# Copy files for xmonad

	cp xmonad/xmonad-startup $(HOME)/.dotfiles/xmonad
	sudo rm -f /usr/bin/xmonad-startup 
	sudo ln -s $(HOME)/.dotfiles/xmonad/xmonad-startup /usr/bin/xmonad-startup
	sudo cp xmonad/xmonad.desktop /usr/share/xsessions/
	cp xmonad/background.jpg $(HOME)/.dotfiles/background.jpg
	
uninstall:

	rm -rf $(HOME)/.dotfiles
	sudo rm -f /usr/bin/xmonad-startup
	sudo cp xmonad/xmonad.desktop.default /usr/share/xsessions/xmonad.desktop
	

