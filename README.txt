 WARNING: This funplug is still beta!

 WARNING: You cannot use these packages with earlier funplug versions!

 The install image is now fun_plug.tgz (was fun_plug.tar). 

 The uncompressed fun_plug.tgz requires approx. 7MB disk space, a full
 installation of all packages approx. 300MB. See below ("Getting
 started") for instructions.


FUN-PLUG 0.5

 THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 PERFORMANCE OF THIS SOFTWARE.


Getting started:

  Copy fun_plug and fun_plug.tgz to Volume 1 and reboot. If
  successful, the fun_plug.tgz file is unpacked (ffp directory) and
  deleted. A telnet server is started.

  Many programs are included in the install tarball, e.g.

    * Lighttpd Web Server
    * OpenSSH Secure Shell
    * Mediatomb UPnP Media Server
    * NTP Network Time Daemon
    * UNFS3 User-Space NFS Server
    * NFS-Utils NFS Server (required kernel support)
    * RSync File Transfer Utility
   
  For more detailed instructions on how to configure and use
  these programs, see:

    http://wiki.dns323.info/howto:ffp#experimental_version_0.5
 
  Using rsync, you can download and install additional packages with:

    telnet bob
    cd /mnt/HD_a2
    rsync -av inreto.de::dns323/fun-plug/0.5/packages .
    cd packages
    funpkg -i *.tgz

  For more information, please visit the the DNS-323 wiki and forums at
    http://wiki.dns323.info/howto:ffp
  and
    http://forum.dsmg600.info/f3-DNS-323-General-Discussion.html

  The build scripts are available via subversion. You can download the
  latest revision with:
    svn co svn://inreto.de/svn/dns323/funplug/trunk funplug


Release notes:

- By default, the 0.5 funplug is installed to /mnt/HD_a2/ffp, but
  compiled with /ffp as prefix. The fun_plug script creates a symbolic
  link /ffp -> /mnt/HD_a2/ffp that allows the programs to run.  If you
  move the funplug (e.g. to run off a USB key), adjust the FFP_PATH
  variable in the fun_plug script accordingly (and add code to mount
  the USB key).

- The 0.5 version is built with a custom toolchain based on
  binutils-2.18, gcc-4.1 and uClibc-0.9.29. Consequently, the 0.5
  funplug comes with its own set of runtime libraries in
  /ffp/lib. (Earlier fun-plugs used a toolchain created from the GPL
  sources tarball provided by D-Link and were linked against the
  firmware libraries in /lib.)

- Native binutils and gcc packages are available. Programs compiled
  with these tools will depend on /ffp/lib/ld-uClibc.so.0 as dynamic
  linker and cannot be used without this funplug (unless you know how
  to change the dynamic linker path at compile-time). Compiler and
  linker will also search the /ffp/include and /ffp/lib directories
  for include files and libraries.
 
- All development files (include files, static libraries, etc) are
  included in the respective package files. There are no binary-only
  or development packages. For some packages to compile successfully,
  it may be necessary to relink /bin/sh to /ffp/bin/bash.
  
- The included dns323-utils (dns323-temp, -fan, ...) will use
  libraries in /ffp, too. If you want them to run with firmware
  libraries (e.g. to prevent disk accesses), use a package from here:
   http://www.inreto.de/dns323/utils/
  
