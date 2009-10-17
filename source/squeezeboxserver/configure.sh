
# Removed: run slimserver as nobody instead

# ensure slimserver user and group are present
#if ! grep -wq slimserver /etc/group; then
#    echo "Adding slimserver group"
#    groupadd -g 612 slimserver
#fi
#if ! grep -wq slimserver /etc/passwd; then
#    echo "Adding slimserver user"
#    useradd -u 612 -d /no/where -g slimserver -s /bin/false slimserver
#fi

