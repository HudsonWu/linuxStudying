 XFCE DESKTOP
apt-get install kali-defaults kali-root-login desktop-base xfce4 xfce4-places-plugin xfce4-goodies
apt-get remove xfce4 xfce4-places-plugin xfce4-goodies
 SET DEFAULT
update-alternatives --display x-window-manager
update-alternatives --config x-window-manager

 xorg config file
/etc/init.d/lightdm stop || /etc/init.d/gdm3 stop
cd /etc/X11/
Xorg -configure
reboot
cd /etc/X11/
Xorg -configure
