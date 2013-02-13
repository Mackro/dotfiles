default:

install:

	sudo apt-get install feh vim
	
	rm -rf $(HOME)/.dotfiles
	mkdir $(HOME)/.dotfiles
	mkdir $(HOME)/.dotfiles/xmonad
	mkdir $(HOME)/.dotfiles/git


	cp git/gitconfig $(HOME)/.dotfiles/git
	sudo rm $(HOME)/.gitconfig
	ln -s $(HOME)/.dotfiles/git/gitconfig $(HOME)/.gitconfig

	cp xmonad/xmonad-startup $(HOME)/.dotfiles/xmonad
	sudo rm -f /usr/bin/xmonad-startup 
	sudo ln -s $(HOME)/.dotfiles/xmonad/xmonad-startup /usr/bin/xmonad-startup
	sudo cp xmonad/xmonad.desktop /usr/share/xsessions/
	cp xmonad/background.jpg $(HOME)/.dotfiles/background.jpg
	
uninstall:

	rm -f $(HOME)/.gitconfig
	rm -rf $(HOME)/.dotfiles
	sudo rm -f /usr/bin/xmonad-startup
	sudo cp xmonad/xmonad.desktop.default /usr/share/xsessions/xmonad.desktop
	

