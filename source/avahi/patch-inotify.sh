# disable inotify
sed -i '/have_inotify=yes/ s,yes,no,' configure

