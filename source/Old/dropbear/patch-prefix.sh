    cp options.h{,.orig}
    sed -e "/^#define _PATH_SSH_PROGRAM/ s:/usr/:$CPREFIX/:" \
        -e "/^#define DSS_PRIV_FILENAME/ s:/etc:$CPREFIX/etc:" \
        -e "/^#define RSA_PRIV_FILENAME/ s:/etc:$CPREFIX/etc:" \
        -e "/^#define SFTPSERVER_PATH/ s:/usr/:$CPREFIX/:" \
        options.h.orig >options.h

