LOCAL_PATH = $(shell pwd)

# Groups

laptop:

	make _common
	make _xmonad_laptop

desktop:

	make _common
	make _xmonad_desktop

_common:

	make _zsh
	make _git
	make _vim

# Parts

_zsh:

	rm -f $(HOME)/.zshrc
	rm -rf $(HOME)/.oh-my-zsh
	ln -s $(LOCAL_PATH)/zsh/zshrc $(HOME)/.zshrc
	ln -s $(LOCAL_PATH)/oh-my-zsh $(HOME)/.oh-my-zsh
	chsh -s /bin/zsh

_git:

	rm -f $(HOME)/.gitconfig
	ln -s $(LOCAL_PATH)/git/gitconfig $(HOME)/.gitconfig

_vim:

	rm -f $(HOME)/.vimrc
	ln -s $(LOCAL_PATH)/vim/vimrc $(HOME)/.vimrc

_xmonad_laptop:

	make _xmonad_common
	sudo rm -f /usr/bin/xmo-battery
	sudo ln -s $(LOCAL_PATH)/tools/xmo-battery /usr/bin/xmo-battery
	rm -f $(HOME)/.xmobarrc
	ln -s $(LOCAL_PATH)/xmonad/xmobarrc.laptop $(HOME)/.xmobarrc

_xmonad_desktop:

	make _xmonad_common
	rm -f $(HOME)/.xmobarrc
	ln -s $(LOCAL_PATH)/xmonad/xmobarrc.desktop $(HOME)/.xmobarrc

_xmonad_common:

	rm -f $(HOME)/.xmonad_background.jpg
	sudo rm -f /usr/share/xsessions/xmonad.desktop
	sudo rm -f /bin/xmonad-startup
	mkdir -p $(HOME)/.xmonad
	rm -f $(HOME)/.xmonad/xmonad.hs
	ln -s $(LOCAL_PATH)/xmonad/background.jpg $(HOME)/.xmonad_background.jpg
	ln -s $(LOCAL_PATH)/xmonad/xmonad.hs $(HOME)/.xmonad/xmonad.hs
	sudo ln -s $(LOCAL_PATH)/xmonad/xmonad.desktop /usr/share/xsessions/xmonad.desktop
	sudo ln -s $(LOCAL_PATH)/xmonad/xmonad-startup /bin/xmonad-startup

