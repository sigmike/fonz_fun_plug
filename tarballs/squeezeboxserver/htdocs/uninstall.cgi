#!/ffp/bin/sh

page()
{
    page_title "Uninstall Fun-Plug"
    box \
	"You're about to uninstall Fun-Plug. Are you sure?" \
	$(br; link "do-uninstall.cgi" "Yes, really uninstall now!")
}

. ./page.sh
