default:

install:

	rm -rf $(HOME)/.dotfiles
	mkdir $(HOME)/.dotfiles

	cp xmonad-startup $(HOME)/.dotfiles

	sudo rm -f /usr/bin/xmonad-startup 
	sudo ln -s $(HOME)/.dotfiles/xmonad-startup /usr/bin/xmonad-startup
	sudo cp xmonad.desktop /usr/share/xsessions/
	cp background.jpg $(HOME)/.dotfiles/background.jpg
	

uninstall:

	rm -rf $(HOME)/.dotfiles
	sudo rm -f /usr/bin/xmonad-startup
	sudo cp xmonad.desktop.default /usr/share/xsessions/xmonad.desktop


