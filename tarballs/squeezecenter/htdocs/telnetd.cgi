#!/ffp/bin/sh

page()
{
    page_title "Telnet Server"

    # check for slimserver installation
    if [ ! -e /ffp/start/telnetd.sh ]; then
	box "Telnet server is not installed."
	return 0
    fi

    # process commands
    case "$1" in

	start)
	    box_head "Starting Telnet server "
	    chmod a+x /ffp/start/telnetd.sh
	    ( cd /; sh /ffp/start/telnetd.sh start >/dev/null )
	    box_tail
	    ;;

	stop)
	    box_head "Stopping Telnet server"
	    chmod a-x /ffp/start/telnetd.sh
	    sh /ffp/start/telnetd.sh stop >/dev/null
	    box_tail

    esac

    # get status
    if sh /ffp/start/telnetd.sh status | grep -vwq not; then
	telnetd_status="running"
    else
	telnetd_status="stopped"
    fi

    # print status
    box_head
    cat <<EOF
 <table>
  <tr><th>Status</th>
      <td>$telnetd_status</td>
  </tr>
 </table>
EOF
    box_tail

    if [ -z "$action" ]; then
	# commands
	box_head
	case "$telnetd_status" in
	    running)
		link "?stop" "Stop Telnet Server"
		;;
	    stopped)
		link "?start" "Start Telnet Server"
		;;
	esac
	box_tail
    else
	back_box
    fi

}

. ./page.sh
