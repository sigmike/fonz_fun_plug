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

Start SSH:

    chmod a+x /ffp/start/sshd.sh
    sh /ffp/start/sshd.sh start

Try to connect to your NAS with SSH. If it works, disable telnet:

    chmod -x /ffp/start/telnetd.sh

And reboot your NAS or `killall telnetd`.

You're done.
