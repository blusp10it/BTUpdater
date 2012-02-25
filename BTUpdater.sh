#!/bin/bash

trap keluar INT

# Tampil pesan
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

# Keluar
keluar () {
if [ -e "/tmp/testping" ] ; then
     tampil aksi "Membersihkan..."
     rm -f /tmp/testping
     sleep 1
elif [ -e "$(pwd)/index.html" ] ; then
     tampil aksi "Membersihkan..."
     rm -f $pwd/index.html
     sleep 1
fi
exit
}

# Cek
cek () {
if [ "$1" == "koneksi" ] ; then
     internet=""
     tampil aksi "Cek koneksi..."
     sleep 1
     wget -nv "http://www.google.com" -o /tmp/testping
     if [ -e "$pwd/index.html" ] ; then
          internet="true"
          tampil inform "Kamu terkoneksi dengan internet"
          sleep 1
     else
          internet="false"
          tampil peringatan "Kamu tidak memiliki koneksi internet!"
          sleep 1
     fi
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
elif [ "$1" == "SET" ] ; then
     missSet=""
     dirSet=""
     setdir="/pentest/exploits/set/"
     SETdir="/pentest/exploiits/SET/"
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
fi
}

# Install
grab () {
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
elif [ "$1" == "SET" ] ; then
     loop="true"
     while [ "$loop" != "false" ] ; do
          echo -en "[?] Apakah kamu mau menginstall SET? [y/n] "
          read keputusan
          if [ "$keputusan" == "y" ] || [ "$keputusan" == "Y" ] ; then
               tampil aksi "Menginstall SET..."
               `apt-get install set`
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
fi
}
# Update
update () {
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
fi
}

# Program berjalan
while : ; do
reset
     cat << BANNER
------------------------------------------------------
                  BackTrack 5 Updater
------------------------------------------------------
Script ini dapat mengupdate software-software berikut:
[M]etasploit
[W]3af
[E]xploitDB
[S]ET
------------------------------------------------------
BANNER
     read -p "[M/W/E/S] atau [K]eluar : "
     case "$REPLY" in
          M|m) update metasploit ;;
          W|w) update w3af ;;
          E|e) update exploitdb ;;
          S|s) update SET ;;
      K|k|X|x) keluar ;;
          *) tampil error "Pilihan tidak valid $REPLY" && sleep 1 ;;
     esac
done
