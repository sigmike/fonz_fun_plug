#!/ffp/bin/sh

page()
{

    page_title "Welcome to the Squeezecenter Fun-Plug"
    # process commands
#    action="$1"
#    shift

    #case "$action" in
#	uninstall)
#	    box \
#		"You're about to uninstall Fun-Plug. Are you sure?" \
#		$(br; link "do-uninstall.cgi" "Yes, uninstall now")
#	    return
#	    ;;
#    esac

    #box "Welcome to the Squeezecenter Fun-Plug"

    # links to other servers on this host
    box_head "Go to ...<ul>"

    # strip port from hostname
    host=$(echo $HTTP_HOST | sed 's/:[^:]*$//')
    if netstat -tln 2>/dev/null | grep -wq 9000; then
	echo "<li>$(link "http://$host:9000/" "Slimserver Web Interface")</li>"
    fi
    
    if netstat -tlnp 2>/dev/null | grep -w 80 | grep -wq webs; then
	echo "<li>$(link "http://$host/" "Firmware Web Interface")</li>"
    fi
    
    if netstat -tlnp 2>/dev/null | grep -w 81 | grep -wq webs; then
	echo "<li>$(link "http://$host:81/" "Firmware Web Interface")</li>"
    fi
    
    box_tail "</ul>"

    # uninstall function
    box_head "To disable and remove the Fun-Plug, select"
    link "uninstall.cgi" "Uninstall Fun-Plug"
    box_tail
}

. ./page.sh

