def()
{
	while [ $# -gt 0 ]; do
		dst=$(echo $1 | sed 's,\.new$,,')
		if [ ! -r "$dst" ]; then
			mv $1 $dst
		elif cmp -s $1 $dst; then
			rm $1
		fi
		shift
	done
}

def ffp/etc/avahi/*.new ffp/etc/avahi/*/*.new

