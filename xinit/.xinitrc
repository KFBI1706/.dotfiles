dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export XDG_DATA_DIRS="/usr/share:/usr/local/share:$HOME/.local/share/applications:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share/applications"



xrdb -merge ~/.Xresources

exec dbus-launch i3
