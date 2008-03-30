    mkdir -p $D$CPREFIX/bin
    for p in dns323-poweroff dns323-leds dns323-fan dns323-temp dns323-spindown dns323-rtc; do
        install -m 0755 $p $D$CPREFIX/bin
    done

