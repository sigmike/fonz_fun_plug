FUN-PLUG 0.5

 WARNING: This funplug package is still beta!
 WARNING: You cannot use these packages with earlier funplug versions!


 THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 PERFORMANCE OF THIS SOFTWARE.


Getting started on DNS-323 and CH3SNAS:

  Copy fun_plug and fun_plug.tgz to Volume 1 and reboot. If
  successful, the fun_plug.tgz file is unpacked (ffp directory) and
  deleted. A telnet server is started.

  Many programs are included in the tarball, e.g.

    * Lighttpd Web Server
    * OpenSSH Secure Shell
    * Mediatomb UPnP Media Server
    * NTP Network Time Daemon
    * UNFS3 User-Space NFS Server
    * NFS-Utils NFS Server (requires kernel support)
    * RSync File Transfer Utility
   
  Using rsync, you can download and install additional packages with:

    telnet bob
    cd /mnt/HD_a2
    rsync -av inreto.de::dns323/fun-plug/0.5/packages .
    cd packages
    funpkg -i *.tgz

  The uncompressed fun_plug.tgz requires approx. 40MB disk space, a
  full installation of all packages currently 450MB.
  For the full list of available packages see PACKAGES.html.

  For more information, and a list of contributed packages, please
  visit the DNS-323 wiki and forums at

    http://wiki.dns323.info/howto:ffp#version_0.5
  and
    http://forum.dsmg600.info/f3-DNS-323-General-Discussion.html


  The build scripts used to create ffp are available from a subversion
  repository. You can download the latest revision with:

    svn co svn://inreto.de/svn/dns323/funplug/trunk funplug


Release notes:

- By default, the 0.5 funplug is installed to /mnt/HD_a2/ffp, but
  compiled with /ffp as prefix. The fun_plug script creates a symbolic
  link /ffp -> /mnt/HD_a2/ffp that allows the programs to run.  If you
  move the funplug (e.g. to run on a USB stick), and adjust the
  FFP_PATH variable in the fun_plug script accordingly (don't forget
  to add code to mount the USB stick).

- For the DNS-323, there's a method to boot ffp and a recent kernel
  with NFS support:
    http://wiki.dns323.info/howto:ffp-reloaded

- The 0.5 version is built with a custom toolchain based on
  binutils-2.18, gcc-4.1 and uClibc-0.9.29. Consequently, the 0.5
  funplug comes with its own set of runtime libraries in
  /ffp/lib. (Earlier fun-plugs used a toolchain created from the GPL
  sources tarball provided by D-Link, and were linked against the
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


ffp on other devices:

- D-Link DNS-313:
    http://forum.dsmg600.info/t2008-HOWTO%3A-DNS-313-fun_plug-dummies-them%29.html

- chroot'ed on Zyxel NSA-220:
    http://forum.dsmg600.info/t2542-fun_plug-ZyXEL-NSA-220..html
    http://forums.nas-central.org/viewtopic.php?f=131&t=191

- Linksys WRT 350N wireless routers:
    http://www.linksysinfo.org/forums/showthread.php?t=57932

