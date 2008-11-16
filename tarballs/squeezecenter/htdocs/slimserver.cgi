#!/ffp/bin/sh

page()
{
    page_title "Slimserver"

    # check for slimserver installation
    if [ ! -e /ffp/start/slimserver.sh ]; then
	box "Slimserver is not installed."
	return 0
    fi

    # process commands
    case "$1" in

	start)
	    box_head "Starting Slimserver<br/>Please wait"

	    chmod a+x /ffp/start/mysqld.sh
	    chmod a+x /ffp/start/slimserver.sh

	    sh /ffp/start/mysqld.sh start >/dev/null
	    echo -n .
	    sleep 5
	    # ensure mysql started
	    if sh /ffp/start/mysqld.sh status | grep -vwq not; then
		sh /ffp/start/slimserver.sh start >/dev/null
		while sh /ffp/start/slimserver.sh status | grep -vwq not; do
		    if netstat -tln | grep -wq 9000; then
			break
		    fi
		    echo -n .
		    sleep 5
		done
	    fi
	    if ! netstat -tln | grep -wq 9000; then
		echo "FAILED"
		sh /ffp/start/mysqld.sh stop >/dev/null 2>/dev/null
	    fi
	    box_tail
	    ;;

	stop)
	    box_head "Stopping Slimserver<br/>Please wait"

	    chmod a-x /ffp/start/mysqld.sh
	    chmod a-x /ffp/start/slimserver.sh

	    sh /ffp/start/slimserver.sh stop >/dev/null
	    while sh /ffp/start/slimserver.sh status | grep -vwq not; do
		echo -n .
		sleep 5
	    done
	    sh /ffp/start/mysqld.sh stop >/dev/null
	    while sh /ffp/start/mysqld.sh status | grep -vwq not; do
		echo -n .
		sleep 5
	    done
	    box_tail

    esac

    # get status
    if sh /ffp/start/slimserver.sh status | grep -vwq not; then
	slimserver_status="running"
    else
	slimserver_status="stopped"
    fi

    # print status
    box_head
    cat <<EOF
 <table>
  <tr><th>Status</th>
      <td>$slimserver_status</td>
  </tr>
 </table>
EOF
    box_tail

    case "$action" in
	view-log)
	    file_box /ffp/lib/squeezecenter/Logs/server.log
	    ;;
    esac

    if [ -z "$action" ]; then
	# commands
	box_head
	if [ "$slimserver_status" = "stopped" ]; then
	    link "?start" "Start Slimserver"
	    br
	elif [ "$slimserver_status" = "running" ]; then
	    link "?stop" "Stop Slimserver"
	    br
	fi
    
	# view the log
	link "?view-log" "View Slimserver Log"
	br

	box_tail

    else
	back_box
    fi    
}

. ./page.sh
