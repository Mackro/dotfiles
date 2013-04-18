LOCAL_PATH = $(shell pwd)

# Groups

all_laptop:

	make all_common
	make xmonad_laptop

all_desktop:

	make all_common
	make xmonad_desktop

all_common:

	make zsh
	make git
	make vim
	make tools
	make gnome_terminal

# Parts

gnome_terminal:
	rm -rf $(HOME)/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml	
	ln -s $(LOCAL_PATH)/gnome-terminal/%gconf.xml $(HOME)/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml
	
zsh:

	rm -f $(HOME)/.zshrc
	rm -rf $(HOME)/.oh-my-zsh
	ln -s $(LOCAL_PATH)/zsh/zshrc $(HOME)/.zshrc
	ln -s $(LOCAL_PATH)/oh-my-zsh $(HOME)/.oh-my-zsh
	chsh -s /bin/zsh

git:

	rm -f $(HOME)/.gitconfig
	ln -s $(LOCAL_PATH)/git/gitconfig $(HOME)/.gitconfig

vim:

	rm -f $(HOME)/.vimrc
	rm -rf $(HOME)/.vim
	ln -s $(LOCAL_PATH)/vim/vimrc $(HOME)/.vimrc
	ln -s $(LOCAL_PATH)/vim/vim $(HOME)/.vim

tools:

	sudo rm -f /usr/bin/wvim
	sudo ln -s $(LOCAL_PATH)/tools/wvim /usr/bin/wvim

	sudo rm -f /usr/bin/verbose_clock
	sudo ln -s $(LOCAL_PATH)/tools/verbose_clock /usr/bin/verbose_clock

xmonad_laptop:

	make xmonad_common

	sudo rm -f /usr/bin/xmo-battery
	sudo ln -s $(LOCAL_PATH)/tools/xmo-battery /usr/bin/xmo-battery
	
	rm -f $(HOME)/.xmobarrc
	ln -s $(LOCAL_PATH)/xmonad/xmobarrc.laptop $(HOME)/.xmobarrc

xmonad_desktop:

	make xmonad_common
	
	rm -f $(HOME)/.xmobarrc
	ln -s $(LOCAL_PATH)/xmonad/xmobarrc.desktop $(HOME)/.xmobarrc

xmonad_common:

	rm -f $(HOME)/.xmonad_background.jpg
	sudo rm -f /usr/share/xsessions/xmonad.desktop
	sudo rm -f /bin/xmonad-startup
	
	mkdir -p $(HOME)/.xmonad
	rm -f $(HOME)/.xmonad/xmonad.hs
	
	ln -s $(LOCAL_PATH)/xmonad/background.jpg $(HOME)/.xmonad_background.jpg
	ln -s $(LOCAL_PATH)/xmonad/xmonad.hs $(HOME)/.xmonad/xmonad.hs
	sudo ln -s $(LOCAL_PATH)/xmonad/xmonad.desktop /usr/share/xsessions/xmonad.desktop
	sudo ln -s $(LOCAL_PATH)/xmonad/xmonad-startup /bin/xmonad-startup
