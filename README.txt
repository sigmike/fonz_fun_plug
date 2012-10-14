FUN-PLUG 0.7

 WARNING: You cannot use these packages with earlier funplug versions!

 THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 PERFORMANCE OF THIS SOFTWARE.

Getting started

  This is the "arm" version, for DNS-325 (and other EABI-based devices).
  For DNS-323 and CH3SNAS (and other OABI-based devices), use the
  "oabi" version.

  Copy fun_plug and fun_plug.tgz to Volume 1 and reboot. If
  successful, the fun_plug.tgz file is unpacked (ffp directory) and
  deleted. A telnet server is started.

  Many programs are included in the tarball, e.g.

    * Lighttpd Web Server
    * OpenSSH Secure Shell
    * RSync File Transfer Utility
    * NTP Network Time Daemon
    * NFS-Utils NFS Server (requires kernel support)
    * Bash Bourne-Again Shell
    * Perl Scripting Language
    * Vim Text Editor

  Using the 'slacker' tool, you can download and install additional
  packages.

    # slacker -Ui s:

  See also PACKAGES.html in {arm,oarm}/packages/ for a list of
  available packages.

  For more information, please visit the forums and wiki at:

    http://forum.dsmg600.info/
    http://wiki.dns323.info/howto:ffp


