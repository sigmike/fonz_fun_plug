Full explaination and source:
http://forum.dsmg600.info/viewtopic.php?pid=45488#p45488

Put fun_plug and fun_plug.tgz in the root of Volume_1
Reboot the NAS
Wait until fun_plug.tgz is removed
telnet to your NAS, should get a "sh-4.1#" prompt.

Run these commands:

    usermod -s /ffp/bin/sh root
    mkdir -p /ffp/home/root/
    sed -ie 's#:/home/root:#:/ffp/home/root:#g' /etc/passwd
    pwconv

Change root's password and log in:

    passwd
    login

Store the configuration:

    wget http://wolf-u.li/u/172/ -O /ffp/sbin/store-passwd.sh
    store-passwd.sh

If ever the URL doesn't work, try this command: `wget --no-check-certificate https://raw.github.com/piglop/fonz_fun_plug/dsl320-0.7/store-passwd.sh -O /ffp/sbin/store-passwd.sh`

Start SSH:

    chmod a+x /ffp/start/sshd.sh
    sh /ffp/start/sshd.sh start

Try to connect to your NAS with SSH. If it works, disable telnet:

    chmod -x /ffp/start/telnetd.sh

And reboot your NAS or `killall telnetd`.

You're done.

Repository selection
Package installation
====================

Source and informations: http://dns323.kood.org/howto:ffp#slacker_sites

You can select repositories graphically or manually:

Graphical selection
-------------------

To select repositories graphically:

    wget http://wolf-u.li/u/441 -O /ffp/bin/uwsiteloader.sh
    chmod a+x /ffp/bin/uwsiteloader.sh
    uwsiteloader.sh

If ever the URL doesn't work, try this command: `wget --no-check-certificate https://raw.github.com/SirUli/funplug/master/0.7/ffpscripts/uwsiteloader.sh -O /ffp/bin/uwsiteloader.sh`

Manual selection
----------------

Copy some URL from http://dns323.kood.org/howto:ffp#slacker_sites to
`/ffp/etc/funpkg/sites` and run `slacker -U`.

Package installation
====================

You can select packages to install with `slacker -a [<pattern>]`
