#!/ffp/bin/sh

page()
{
    page_title "Uninstalling Fun-Plug"
    
    # check for slimserver installation
    if [ ! -e /ffp/sbin/uninstall-ffp.sh ]; then
	box "Uninstall command not found"
	return 0
    fi

    box "Running uninstall command. Bye bye."

    # do it
    ( sleep 2; /ffp/sbin/uninstall-ffp.sh now; sleep 2 ) &
}

. ./page.sh
