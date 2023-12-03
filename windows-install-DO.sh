#!/bin/bash
#
# CREATED By NIXPOIN.COM
#
echo "Pilih OS yang ingin anda install"
echo "	1) Windows 2019(Default)"
echo "	2) Windows 2016"
echo "	3) Windows 2012"
echo "	4) Windows 10"
echo "	5) Windows 2022"
echo "	6) Pakai link gz mu sendiri"

read -p "Pilih [1]: " PILIHOS

case "$PILIHOS" in
	1|"") PILIHOS="https://gd.seno.my.id/download.aspx?file=DVRxVn14vU1JgqujffdP9KRuSAm7PjgX36KESj1mdZ1wbCoV2xA28cxvnVh5HWo9&expiry=mJ5ZFQpjvyTyikPBq2ejGQ%3D%3D&mac=51e247911f126d760aa395ad453b066b8b0fdb7b7686f83e2c067ba93136e990"  IFACE="Ethernet Instance 0 2";;
	2) PILIHOS="https://files.sowan.my.id/windows2016.gz"  IFACE="Ethernet Instance 0 2";;
	3) PILIHOS="https://files.sowan.my.id/windows2012.gz"  IFACE="Ethernet";;
	4) PILIHOS="https://gd.seno.my.id/download.aspx?file=tlOt5QULc7bW5Bc1S%2BMewUJ0kcoBt4biCBFgqT3vU%2BJSWEBvV3aZGrECNwIPIlU6&expiry=XNKAflzLo9vnY1dEP%2BwIwg%3D%3D&mac=9ecebea70792b526b77352c7bf523dbd4bb54b3127d4d7b3f2d4355703535b5d"  IFACE="Ethernet Instance 0 2";;
	5) PILIHOS="https://files.sowan.my.id/windows2022.gz"  IFACE="Ethernet Instance 0 2";;
	6) read -p "Masukkan Link GZ mu : " PILIHOS;;
	*) echo "pilihan salah"; exit;;
esac

echo "Merasa terbantu dengan script ini? Anda bisa memberikan dukungan melalui QRIS kami https://nixpoin.com/qris"

read -p "Masukkan password untuk akun Administrator (minimal 12 karakter): " PASSADMIN

IP4=$(curl -4 -s icanhazip.com)
GW=$(ip route | awk '/default/ { print $3 }')
IFACE="Ethernet Instance 0 2"
IFACE2="Ethernet"
IFACE3="Ethernet Instance 0"
cat >/tmp/net.bat<<EOF
@ECHO OFF

netsh -c interface ip set address name="$IFACE2" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="$IFACE2" address=1.1.1.1 index=1 validate=no
netsh -c interface ip add dnsservers name="$IFACE2" address=8.8.4.4 index=2 validate=no

netsh -c interface ip set address name="$IFACE3" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="$IFACE3" address=1.1.1.1 index=1 validate=no
netsh -c interface ip add dnsservers name="$IFACE3" address=8.8.4.4 index=2 validate=no

netsh -c interface ip set address name="$IFACE" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="$IFACE" address=1.1.1.1 index=1 validate=no
netsh -c interface ip add dnsservers name="$IFACE" address=8.8.4.4 index=2 validate=no


cd.>%windir%\GetAdmin
if exist %windir%\GetAdmin (del /f /q "%windir%\GetAdmin") else (
echo CreateObject^("Shell.Application"^).ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\Admin.vbs"
"%temp%\Admin.vbs"
del /f /q "%temp%\Admin.vbs"
exit /b 2)

netsh -c interface ip set address name="$IFACE" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="$IFACE" address=1.1.1.1 index=1 validate=no
netsh -c interface ip add dnsservers name="$IFACE" address=8.8.4.4 index=2 validate=no

netsh -c interface ip set address name="$IFACE2" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="$IFACE2" address=1.1.1.1 index=1 validate=no
netsh -c interface ip add dnsservers name="$IFACE2" address=8.8.4.4 index=2 validate=no

netsh -c interface ip set address name="$IFACE3" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="$IFACE3" address=1.1.1.1 index=1 validate=no
netsh -c interface ip add dnsservers name="$IFACE3" address=8.8.4.4 index=2 validate=no
net user Administrator $PASSADMIN

cd /d "%ProgramData%/Microsoft/Windows/Start Menu/Programs/Startup"
del /f /q net.bat
exit
EOF



wget --no-check-certificate -O- $PILIHOS | gunzip | dd of=/dev/vda bs=3M status=progress

mount /dev/vda2 /mnt
cd "/mnt/ProgramData/Microsoft/Windows/Start Menu/Programs/"
cd Start* || cd start*; \
wget https://nixpoin.com/ChromeSetup.exe
cp -f /tmp/net.bat net.bat


echo 'Your server will turning off in 3 second'
sleep 3
poweroff
