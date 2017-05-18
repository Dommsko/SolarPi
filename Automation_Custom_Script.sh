#!/bin/bash

#------------------------------------------------------------------------------------------------------
# SolarPi - Installation script
#------------------------------------------------------------------------------------------------------
# by Domme

# This file is executed after the successful installation of DietPi OS.
# Solarcoind is downloaded, compiled and configured as a service.

# You may select a custom RPC password here.
# If you don't, a strong random password is generated (recommended).
# As a normal user you won't need the RPC password anyway.
# This file will be deleted after the installation is completed.
# Nevertheless, it's never a good idea to store any password in plain text.
# It is more secure to edit ~/.solarcoin/solarcoin.conf after the installation.

rpcpassword=0

# NO CHANGES BELOW THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING!










# Start setup
echo "Starting installation process..." > ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log



# Update OS
cd
echo "Updating OS..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
apt-get update
apt-get upgrade -y



# Increase swap size
echo "Increasing swap size..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
sed -i "s/\(CONF_SWAPSIZE *= *\).*/\11024/" /etc/dphys-swapfile
dphys-swapfile setup
dphys-swapfile swapon



# Install dependencies
echo "Installing dependencies..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
apt-get install autoconf libevent-dev libtool libssl-dev libboost-all-dev libminiupnpc-dev libdb-dev libdb4.8++ libdb5.3++-dev git hardening-includes rng-tools g++ make -y



# Build BerkeleyDB
echo "Downloading BerkeleyDB..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
sudo tar -xzvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix
../dist/configure --enable-cxx --disable-shared
echo "Building BerkeleyDB..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
make
echo "Installing BerkeleyDB..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
make install
export CPATH="/usr/local/BerkeleyDB.4.8/include"
export LIBRARY_PATH="/usr/local/BerkeleyDB.4.8/lib"



# Build solarcoind
cd
echo "Downloading solarcoind..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
git clone https://github.com/onsightit/solarcoin.git
cd db-4.8.30.NC/build_unix
../dist/configure --prefix=/usr/local --enable-cxx --disable-shared
cd
cd solarcoin/src
echo "Building solarcoind..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
make -f makefile.unix -e PIE=1
strip solarcoind
hardening-check solarcoind >> ~/solarcoind_setup.log
echo "Installing solarcoind..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
install -m 755 solarcoind /usr/local/bin/solarcoind
cd
solarcoind
echo "Installation process complete! =)" >> ~/solarcoind_setup.log



# Create config file
echo "Creating config file..." >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log
# Generate random password if no custom password is set.
if [ $rpcpassword = 0 ]; then
        rpcpassword=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-64};echo;)
fi
cd ~/.solarcoin/
# Write config file
/bin/cat <<EOM >solarcoin.conf
addnode=162.243.214.120
server=1
daemon=1
rpcuser=solarcoinrpc
rpcpassword=$rpcpassword
listen=1
EOM
chmod 400 solarcoin.conf
sleep 1



# Set up solarcoind as a service
/bin/cat <<EOM >/etc/systemd/system/solarcoind.service
[Unit]
Description=SolarCoin daemon services
After=tlp-init.service

[Service]
Type=forking
ExecStart=/usr/local/bin/solarcoind
PIDFile=/root/.solarcoin/solarcoind.pid
RemainAfterExit=yes
Restart=on-failure
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOM

systemctl enable solarcoind.service
systemctl daemon-reload
systemctl start solarcoind.service

echo "solarcoind is now ready to operate! =)" >> ~/solarcoind_setup.log
echo "Please encrypt your wallet now!" >> ~/solarcoind_setup.log
date >> ~/solarcoind_setup.log



# Clean up
rm -rf db-4.8.30.NC*
rm solarcoind_setup.sh
rm /boot/AUTO_CustomScript.sh
rm /boot/Automation_Custom_Script.sh