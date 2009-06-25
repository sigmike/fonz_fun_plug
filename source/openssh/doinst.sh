def()
{
	if [ ! -r "$1" ]; then
		mv $1.new $1
	elif cmp -s $1 $1.new; then
		rm $1.new
	fi
}

# keep the x-flag of the start script
if [ -x ffp/start/sshd.sh ]; then
	chmod a+x ffp/start/sshd.sh.new
fi

def ffp/start/sshd.sh

