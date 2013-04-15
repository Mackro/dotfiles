#How to do this shit! :D

##Fix wireless drivers
1. Download broadcom's wireless drivers:
	http://www.broadcom.com/support/802.11/linux_sta.php

2. Extract and move the binary from lib
	 sudo mv lib/wlc_hybrid.o_shipped /lib/modules/$(uname -r)/kernel/drivers/net/wireless

3. Do 
	sudo depmod -a

4. Edit /etc/modprobe.d/blacklist.conf, add:
	blacklist b32
	blacklist bcm43xx
	blacklist ssb

5. Cleanup
	rmmod ssb
	sudo modprobe wl

6. Done!
