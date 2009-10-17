echo -en "Content-Type: text/html\r\n\r\n"

# want to see errors
exec 2>&1


# page elements

page_title() {
    echo "<h2>$@</h2>"
}

# element functions

box() { 
    echo "<div class=\"box\">$@</div>" 
}
box_head() { 
    echo "<div class=\"box\">$@" 
}
box_tail() { 
    echo "$@</div>" 
}

file_box() {
    echo "<div class=\"output\"><pre>"
    if [ -r "$1" ]; then
	cat "$1"
    else
	echo "(empty)"
    fi
    echo "</pre></div>"
}

back_box() {
    box "<a href="$SCRIPT_NAME">Back</a>"
}

link() {
    _href="$1"
    shift
    echo "<a href=\"$_href\">$@</a>"
}

br() {
    echo "<br/>"
}

# html head
cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title>Squeezecenter Fun-Plug</title>
	<link rel="stylesheet" type="text/css" href="default.css" />
</head>
<body>
EOF

# page title
cat <<EOF

<div id="title">
<h1>Squeezecenter Fun-Plug</h1>
<pre>
based on ffp-0.5
2008</pre>
</div>

EOF

# menu
cat <<EOF
<div id="menu">

<ul>
<li><a href="index.cgi">Home</a></li>
<li><a href="slimserver.cgi">Slimserver</a></li>
<li><a href="telnetd.cgi">Telnet</a></li>
</ul>

</div>
EOF

# query string contains action
action="$QUERY_STRING"
#box "Action: $action"
#box "<pre>$(set)</pre>"

# content
echo '<div class="page">'
page $action
echo '</div>'

# footer
cat <<EOF
</body>
</html>
EOF
