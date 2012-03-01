#!/bin/bash
#------------------------------COPYRIGHT------------------------------#
# BT Updater Beta Release (Update 3rd party BT Software in one shot)
# Copyright (C) 2012 Krisan Alfa Timur A.K.A blusp10it
# Special Thanks to Omega Hanggara A.K.A red-dragon
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#------------------------------COPYRIGHT------------------------------#

trap keluar INT

#------------------------------Tampil Pesan------------------------------#
tampil () {
keluaran=""
if [ "$1" == "aksi" ] ; then keluaran="\e[01;32m[>]\e[00m" ; fi
if [ "$1" == "inform" ] ; then keluaran="\e[01;33m[i]\e[00m" ; fi
if [ "$1" == "error" ] ; then keluaran="\e[01;31m[!]\e[00m" ; fi
if [ "$1" == "peringatan" ] ; then keluaran="\e[01;34m[W]\e[00m" ; fi
keluaran="$keluaran $2"
echo -e "$keluaran"
return 0
}

#------------------------------Keluar------------------------------#
keluar () {
index=( $(pwd) )
tampil aksi "Membersihkan testping..."
rm -f /tmp/testping > /dev/null
tampil aksi "Membersihkan index.html..."
rm -f $index/index.html* > /dev/null
tampil inform "Are you blusp10it?"
exit
}

#------------------------------Cek------------------------------#
cek () {
#------------------------------Cek Koneksi------------------------------#
if [ "$1" == "koneksi" ] ; then
     internet=""
     index=( $(pwd) )
     tampil aksi "Cek koneksi..."
     if [ -e $pwd/index.html ] ; then rm -f $pwd/index.html* > /dev/null ; fi
     sleep 1
     wget -nv "http://www.google.com" -o /tmp/testping
     command=( $(cat /tmp/testping | grep -w 'index.html') )
     if [ "$command" == "" ] ; then
          internet="false"
          tampil peringatan "Kamu tidak terkoneksi dengan internet"
          sleep 1
     else
          internet="true"
          tampil inform "Kamu memiliki koneksi internet!"
          sleep 1
     fi
#------------------------------Cek Metasploit------------------------------#
elif [ "$1" == "metasploit" ] ; then
     missMsf=""
     msfDir=""
     tampil aksi "Mengecek Metasploit Framework"
     sleep 1
     if [ -d "/opt/framework/" ] ; then
          missMsf="false"
          msfDir="/opt/framework/msf3/"
          tampil inform "Direktori Metasploit = '$msfDir'"
          sleep 1
     elif [ -d "/opt/metasploit/" ] ; then
          missMsf="false"
          msfDir="/opt/metasploit/msf3/"
          tampil inform "Direktori Metasploit = '$msfDir'"
          sleep 1
     else
          missMsf="true"
     fi
#------------------------------Cek W3af------------------------------#
elif [ "$1" == "w3af" ] ; then
     missW3af=""
     w3afDir="/pentest/web/w3af/"
     tampil aksi "Mengecek W3af"
     sleep 1
     if [ -d "$w3afDir" ] ; then
          missW3af="false"
          tampil inform "Direktori W3af = '$w3afDir'"
          sleep 1
     else
          missW3af="true"
     fi
#------------------------------Cek ExploitDB------------------------------#
elif [ "$1" == "exploitdb" ] ; then
     missExdb=""
     tampil aksi "Mengecek Exploit DB"
     exdbDir="/pentest/exploits/exploitdb/"
     sleep 1
     if [ -d "$exdbDir" ] ; then
          missExdb="false"
          tampil inform "Direktori Exploit DB = '$exdbDir'"
          sleep 1
     else
          missExdb="true"
     fi
#------------------------------Cek SET------------------------------#
elif [ "$1" == "SET" ] ; then
     missSet=""
     dirSet=""
     setdir="/pentest/exploits/set/"
     SETdir="/pentest/exploits/SET/"
     tampil aksi "Mengecek SET"
     sleep 1
     if [ -d "$setdir" ] ; then
          missSet="false"
          dirSet="$setdir"
          tampil inform "Direktori SET = '$dirSet'"
     elif [ -d "$SETdir" ] ; then
          missSet="false"
          dirSet="$SETdir"
          tampil inform "Direktori SET = '$dirSet'"
     else
          missSet="true"
     fi
#------------------------------Cek SQLMap------------------------------#
elif [ "$1" == "sqlmap" ] ; then
     missSqlmap=""
     dirSqlmap=""
     sqlmapDir="/pentest/database/sqlmap/"
     tampil aksi "Mengecek SQLMap"
     sleep 1
     if [ -d "$sqlmapDir" ] ; then
          missSqlmap="false"
          dirSqlmap="$sqlmapDir"
          tampil inform "Direktori SQLMap = '$dirSqlmap'"
     else
          missSqlmap="true"
     fi
#------------------------------Cek FireNix------------------------------#
elif [ "$1" == "firenix" ] ; then
     firenixDir=""
     missFirenix=""
     tampil aksi "Mengecek FireNix..."
     tampil info "Default directory FireNix adalah /pentest/blusp10it/Firenix."
     sleep 1
     if [ -d "/pentest/blusp10it/FireNix" ] ; then
          tampil info "Direktori /pentest/blusp10it/FireNix ada."
          missFirenix="false"
          firenixDir="/pentest/blusp10it/FireNix"
     else
          tampil info "Direktori /pentest/blusp10it/FireNix tidak ada."
          missFirenix="true"
     fi
#------------------------------Cek WiFire------------------------------#
elif [ "$1" == "wifire" ] ; then
     firenixDir=""
     missWiFire=""
     tampil aksi "Mengecek WiFire..."
     tampil info "Default directory WiFire adalah /pentest/blusp10it/WiFire."
     sleep 1
     if [ -d "/pentest/blusp10it/WiFire" ] ; then
          tampil info "Direktori /pentest/blusp10it/WiFire ada."
          missWiFire="false"
          WiFireDir="/pentest/blusp10it/WiFire"
     else
          tampil info "Direktori /pentest/blusp10it/WiFire tidak ada."
          missWiFire="true"
     fi
fi
}

#------------------------------Install------------------------------#
grab () {
#------------------------------Install Metasploit------------------------------#
if [ "$1" == "metasploit" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall Metasploit? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall Metasploit Framework..."
               `apt-get install framework`
               tampil inform "Done"
               sleep 1
               loop="false"
               l00p="true"
               while [ "$l00p" != "true" ] ; do
                    echo -en "[?] Apakah kamu mau melakukan update? [y/n] "
                    read choice
                    if [ "$choice" == "y" ] || [ "$choice" == "Y" ] ; then
                         update metasploit
                         l00p="false"
                    elif [ "$choice" == "n" ] || [ "$choice" == "N" ] ; then
                         tampil inform "It is so bad )="
                         sleep 2
                         l00p="false"
                    else
                         tampil error "Bad input"
                    fi
               done
          elif [ "$keputusan" == "n" ] || [ "$keputusan" == "N" ] ; then
               tampil peringatan "Kamu tidak menginstall Metasploit? What the FUCK?!"
               sleep 1
               loop="false"
          else
               tampil error "Pilihan tidak valid [$keputusan]"
               loop="true"
          fi
     done
#------------------------------Install W3af------------------------------#
elif [ "$1" == "w3af" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall w3af? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall W3af..."
               `apt-get install w3af`
               tampil inform "Done"
               sleep 1
               loop="false"
               l00p="true"
               while [ "$l00p" != "true" ] ; do
                    echo -en "[?] Apakah kamu mau melakukan update? [y/n] "
                    read choice
                    if [ "$choice" == "y" ] || [ "$choice" == "Y" ] ; then
                         update w3af
                         l00p="false"
                    elif [ "$choice" == "n" ] || [ "$choice" == "N" ] ; then
                         tampil inform "It is so bad )="
                         sleep 2
                         l00p="false"
                    else
                         tampil error "Bad input"
                    fi
               done
          elif [ "$keputusan" == "n" ] || [ "$keputusan" == "N" ] ; then
               tampil peringatan "Kamu tidak menginstall W3af? What the FUCK?!"
               sleep 1
               loop="false"
          else
               tampil error "Pilihan tidak valid [$keputusan]"
               loop="true"
          fi
     done
#------------------------------Install ExploitDB------------------------------#
elif [ "$1" == "exploitdb" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall ExploitDB? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall ExploitDB..."
               `apt-get install exploitdb`
               tampil inform "Done"
               sleep 1
               loop="false"
               l00p="true"
               while [ "$l00p" != "true" ] ; do
                    echo -en "[?] Apakah kamu mau melakukan update? [y/n] "
                    read choice
                    if [ "$choice" == "y" ] || [ "$choice" == "Y" ] ; then
                         update exploitdb
                         l00p="false"
                    elif [ "$choice" == "n" ] || [ "$choice" == "N" ] ; then
                         tampil inform "It is so bad )="
                         sleep 2
                         l00p="false"
                    else
                         tampil error "Bad input"
                    fi
               done
          elif [ "$keputusan" == "n" ] || [ "$keputusan" == "N" ] ; then
               tampil peringatan "Kamu tidak menginstall ExploitDB? What the FUCK?!"
               sleep 1
               loop="false"
          else
               tampil error "Pilihan tidak valid [$keputusan]"
               loop="true"
          fi
     done
#------------------------------Install SET------------------------------#
elif [ "$1" == "SET" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall SET? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall SET..."
               apt-get install set
               tampil inform "Done"
               sleep 1
               loop="false"
               l00p="true"
               while [ "$l00p" != "true" ] ; do
                    echo -en "[?] Apakah kamu mau melakukan update? [y/n] "
                    read choice
                    if [ "$choice" == "y" ] || [ "$choice" == "Y" ] ; then
                         update SET
                         l00p="false"
                    elif [ "$choice" == "n" ] || [ "$choice" == "N" ] ; then
                         tampil inform "It is so bad )="
                         sleep 2
                         l00p="false"
                    else
                         tampil error "Bad input"
                    fi
               done
          elif [ "$keputusan" == "n" ] || [ "$keputusan" == "N" ] ; then
               tampil peringatan "Kamu tidak menginstall SET? What the FUCK?!"
               sleep 1
               loop="false"
          else
               tampil error "Pilihan tidak valid [$keputusan]"
               loop="true"
          fi
     done
#------------------------------Install SQLMap------------------------------#
elif [ "$1" == "sqlmap" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall SQLMap? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall SQLMap..."
               apt-get install sqlmap -y
               tampil inform "Done"
               sleep 1
               loop="false"
               l00p="true"
               while [ "$l00p" != "true" ] ; do
                    echo -en "[?] Apakah kamu mau melakukan update? [y/n] "
                    read choice
                    if [ "$choice" == "y" ] || [ "$choice" == "Y" ] ; then
                         update sqlmap
                         l00p="false"
                    elif [ "$choice" == "n" ] || [ "$choice" == "N" ] ; then
                         tampil inform "It is so bad )="
                         sleep 2
                         l00p="false"
                    else
                         tampil error "Bad input"
                    fi
               done
          elif [ "$keputusan" == "n" ] || [ "$keputusan" == "N" ] ; then
               tampil peringatan "Kamu tidak menginstall SQLMap? What the FUCK?!"
               sleep 1
               loop="false"
          else
               tampil error "Pilihan tidak valid [$keputusan]"
               loop="true"
          fi
     done
#------------------------------Install FireNix------------------------------#
elif [ "$1" == "firenix" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall FireNix? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall FireNix..."
               tampil aksi "Mengecek direktori"
               if [ -d "/pentest/blusp10it" ] ; then
                    tampil aksi "Menginstall FireNix..."
                    git clone https://blusp10it@github.com/blusp10it/FireNix.git
               else
                    tampil aksi "Membuat direktori /pentest/blusp10it"
                    mkdir /pentest/blusp10it
                    tampil aksi "Menginstall"
                    cd /pentest/blusp10it
                    git clone https://blusp10it@github.com/blusp10it/FireNix.git
                    tampil inform "Done"
                    sleep 1
                    loop="false"
                    l00p="true"
                    while [ "$l00p" != "true" ] ; do
                         echo -en "[?] Apakah kamu mau melakukan update? [y/n] "
                         read choice
                         if [ "$choice" == "y" ] || [ "$choice" == "Y" ] ; then
                              update firenix
                              l00p="false"
                         elif [ "$choice" == "n" ] || [ "$choice" == "N" ] ; then
                              tampil inform "It is so bad )="
                              sleep 2
                              l00p="false"
                         else
                              tampil error "Bad input"
                         fi
                    done
               fi
          elif [ "$keputusan" == "n" ] || [ "$keputusan" == "N" ] ; then
               tampil peringatan "Kamu tidak menginstall FireNix? What the FUCK?!"
               sleep 1
               loop="false"
          else
               tampil error "Pilihan tidak valid [$keputusan]"
               loop="true"
          fi
     done
#------------------------------Install WiFire------------------------------#
elif [ "$1" == "wifire" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall WiFire? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall WiFire..."
               tampil aksi "Mengecek direktori"
               if [ -d "/pentest/blusp10it" ] ; then
                    tampil aksi "Menginstall WiFire..."
                    cd /pentest/blusp10it
                    git clone https://blusp10it@github.com/blusp10it/WiFire.git
               else
                    tampil aksi "Membuat direktori /pentest/blusp10it"
                    mkdir /pentest/blusp10it
                    tampil aksi "Menginstall"
                    cd /pentest/blusp10it
                    git clone https://blusp10it@github.com/blusp10it/WiFire.git
                    tampil inform "Done"
                    sleep 1
                    loop="false"
                    l00p="true"
                    while [ "$l00p" != "true" ] ; do
                         echo -en "[?] Apakah kamu mau melakukan update? [y/n] "
                         read choice
                         if [ "$choice" == "y" ] || [ "$choice" == "Y" ] ; then
                              update wifire
                              l00p="false"
                         elif [ "$choice" == "n" ] || [ "$choice" == "N" ] ; then
                              tampil inform "It is so bad )="
                              sleep 2
                              l00p="false"
                         else
                              tampil error "Bad input"
                         fi
                    done
               fi
          elif [ "$keputusan" == "n" ] || [ "$keputusan" == "N" ] ; then
               tampil peringatan "Kamu tidak menginstall WiFire? What the FUCK?!"
               sleep 1
               loop="false"
          else
               tampil error "Pilihan tidak valid [$keputusan]"
               loop="true"
          fi
     done
fi
}

#------------------------------Update------------------------------#
update () {
#------------------------------Update Metasploit------------------------------#
if [ "$1" == "metasploit" ] ; then
     cek metasploit
     cek koneksi
     if [ "$missMsf" == "true" ] ; then
          tampil error "Metasploit tidak terinstall!"
          sleep 2
          grab metasploit
     elif [ "$missMsf" == "false" ] ; then
          if [ "$internet" == "true" ] ; then
               tampil aksi "Memindahkan direktori yang aktif..."
               cd "$msfDir"
               tampil akse "Melakukan update..."
               svn update
               tampil inform "Selesai (=)"
          elif [ "$internet" == "false" ] ; then
               tampil error "Kamu tidak memiliki akses internet!"
          fi
     fi
#------------------------------Update W3af------------------------------#
elif [ "$1" == "w3af" ] ; then
     cek w3af
     cek koneksi
     if [ "$missW3af" == "false" ] ; then
          if [ "$internet" == "true" ] ; then
               tampil aksi "Memindahkan direktori yang aktif..."
               cd "$w3afDir"
               tampil aksi "Melakukan update..."
               svn update
               tampil inform "Selesai (=)"
          elif [ "$internet" == "false" ] ; then
               tampil error "Kamu tidak memiliki akses internet!"
          fi
     elif [ "$missW3af" == "true" ] ; then
          tampil error "W3af tidak terinstall!"
          sleep 2
          grab w3af
     fi
#------------------------------Update ExploitDB------------------------------#
elif [ "$1" == "exploitdb" ] ; then
     cek exploitdb
     cek koneksi
     if [ "$missExdb" == "false" ] ; then
          if [ "$internet" == "true" ] ; then
               tampil aksi "Memindahkan direktori yang aktif..."
               cd "$exdbDir"
               tampil aksi "Melakukan update..."
               svn update
               tampil inform "Selesai (=)"
          elif [ "$internet" == "false" ] ; then
               tampil error "Kamu tidak memiliki akses internet!"
          fi
     elif [ "$missExdb" == "true" ] ; then
          tampil error "Exploit DB tidak terinstall!"
          sleep 2
          grab exploitdb
     fi
#------------------------------Update SET------------------------------#
elif [ "$1" == "SET" ] ; then
     cek SET
     cek koneksi
     if [ "$missSet" == "false" ] ; then
          if [ "$internet" == "true" ] ; then
               tampil aksi "Memindahkan direktori yang aktif..."
               cd "$dirSet"
               tampil aksi "Melakukan update..."
               svn update
               tampil inform "Selesai"
          elif [ "$internet" == "false" ] ; then
               tampil error "Kamu tidak memiliki akses internet!"
          fi
     elif [ "$missSet" == "true" ] ; then
          tampil error "SET tidak terinstall!"
          grab SET
     fi
#------------------------------Update SQLMap------------------------------#
elif [ "$1" == "sqlmap" ] ; then
     cek sqlmap
     cek koneksi
     if [ "$missSqlmap" == "false" ] ; then
          if [ "$internet" == "true" ] ; then
               tampil aksi "Memindahkan direktori yang aktif..."
               cd "$sqlmapDir" && cd ../
               tampil aksi "Melakukan update..."
               svn checkout https://svn.sqlmap.org/sqlmap/trunk/sqlmap sqlmap/
               tampil inform "Selesai"
          elif [ "$internet" == "false" ] ; then
               tampil error "Kamu tidak memiliki akses internet!"
          fi
     elif [ "$missSqlmap" == "true" ] ; then
          tampil error "SQLMap tidak terinstall!"
          grab sqlmap
     fi
#------------------------------Update BTUpdater------------------------------#
elif [ "$1" == "btupdater" ] ; then
     cek koneksi
     if [ "$internet" == "true" ] ; then
          dir=( $(pwd) )
          tampil aksi "Memindahkan direktori yang aktif..."
          cd $pwd
          tampil aksi "Melakukan update"
          git pull
          tampil inform "Done"
          sleep 1
     else
          tampil error "Kamu tidak memiliki akses internet!"
          sleep 1
     fi
#------------------------------Update FireNix------------------------------#
elif [ "$1" == "firenix" ] ; then
     cek firenix
     cek koneksi
     if [ "$missFirenix" == "false" ] ; then
          if [ "$internet" == "true" ] ; then
               tampil aksi "Memindahkan direktori yang aktif..."
               cd "$firenixDir"
               tampil aksi "Melakukan update..."
               git pull
               tampil inform "Selesai"
          elif [ "$internet" == "false" ] ; then
               tampil error "Kamu tidak memiliki akses internet!"
          fi
     elif [ "$missFirenix" == "true" ] ; then
          tampil error "FireNix tidak terinstall!"
          grab firenix
     fi
#------------------------------Update WiFire------------------------------#
elif [ "$1" == "wifire" ] ; then
     cek wifire
     cek koneksi
     if [ "$missWifire" == "false" ] ; then
          if [ "$internet" == "true" ] ; then
               tampil aksi "Memindahkan direktori yang aktif..."
               cd "$wifireDir"
               tampil aksi "Melakukan update..."
               git pull
               tampil inform "Selesai"
          elif [ "$internet" == "false" ] ; then
               tampil error "Kamu tidak memiliki akses internet!"
          fi
     elif [ "$missWifire" == "true" ] ; then
          tampil error "WiFire tidak terinstall!"
          grab wifire
     fi
fi
}

#------------------------------Program Berjalan ------------------------------#
while : ; do
reset
     cat << BANNER
-------------------------------------------------------------
                      BackTrack 5 Updater
-------------------------------------------------------------
Script ini dapat mengupdate software-software berikut:
[M]etasploit  --- Metasploit Framework
[W]3af        --- Web Application Attack and Audit Framework
[E]xploitDB   --- Vulnerability DB by Offensive Security
[S]ET         --- Social Engineering Toolkit (ReL1K)
S[Q]LMap      --- Automatic Database Takeover Control
[B]TUpdater   --- Update this script (=
[F]ireNix     --- Update FireNix script
W[i]Fire      --- Update WiFire script
-------------------------------------------------------------
BANNER
     read -p "[M/W/E/S/Q/B/F/i] atau [K]eluar : "
     case "$REPLY" in
          M|m) update metasploit ;;
          W|w) update w3af ;;
          E|e) update exploitdb ;;
          S|s) update SET ;;
          Q|q) update sqlmap ;;
          B|b) update btupdater ;;
          F|f) update firenix ;;
          I|i) update wifire ;;
      K|k|X|x) keluar ;;
          *) tampil error "Pilihan tidak valid $REPLY" && sleep 1 ;;
     esac
done
