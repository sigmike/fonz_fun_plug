def()
{
	if [ ! -r "$1" ]; then
		mv $1.new $1
	elif cmp -s $1 $1.new; then
		rm $1.new
	fi
}

def ffp/etc/sudoers

