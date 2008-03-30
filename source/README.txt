30 Mar 2008

You need most of the ffp packages to build packages from source. If
you're unsure, I recommend to install everything.

==== Building a package from source ====

Change to the source directory:

 # cd source

To download required source files (to ../distfiles), run:

 # ./Make.sh -F package-directory

To build the package, run:

 # ./Make.sh package-directory

A build log is written in ../build-logs, the package file is stored in
../packages/.



