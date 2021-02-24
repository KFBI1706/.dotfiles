#export SSH_ASKPASS=ssh-askpass
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
eval $(ssh-agent)
export SSH_AUTH_SOCK
exec dbus-launch i3
