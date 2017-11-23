# SolarPi
![SolarCoin Logo](https://solarcoin.org/sites/default/files/slr-logo.png)

#### Use your Raspberry Pi 3B as a SolarCoin full node
- Unattended installation process
- No additional hardware needed
- Get a free SolarCoin for 1MWh of generated solar electricity
- Gain 2% interest per year by staking your SolarCoins
- Support green energy

#### Find out more: http://www.solarcoin.org

<hr>

#### Introduction

This guide explains how to easily set up a node yourself using a Raspberry Pi 3. You won't have to know about Linux, you won't need an external keyboard or monitor to log on to the Raspberry Pi. After you prepared your SD card with the OS image and configuration files you just insert it into your Pi and that initiates the automated installation.
After the installation process, You will need to log on to the Pi via SSH to encrypt and use your wallet.

#### Hardware Requirements

- Raspberry Pi 3B, older version don't have enough RAM to hold the blockchain index
- Active internet connection
- Device to write on a microSD card

#### Software Requirements

- DietPi - A lightweight OS for your Raspberry - http://www.dietpi.com/download
- Software to upload an .img file onto your microSD card. For more information on this topic please refer to https://www.raspberrypi.org/documentation/installation/installing-images/
- A standard text editor

<hr>

#### Installation

- If you want your Pi to use WiFi, open dietpi.txt and enable Wifi by setting Wifi_Enabled to 1 and edit the lines Wifi_SSID and Wifi_KEY according to your local network.
- If you don't know how to figure out your Pi's IP address afterwards you should set a static IP address.
- Flash the downloaded DietPi .img-file onto your microSD card. This will create two partitions on the card called "boot" and "rootfs". It will take a few minutes depending on your SD card speed.
- Mount/open the microSD card's "boot" partition and copy the files "Automation_Custom_Script.sh" and "dietpi.txt" into the main folder (overwrite the standard dietpi.txt).
- Unmount/safely remove your microSD card.
- Insert the microSD card into your Pi and plug it in.
- The installation process starts. It will take approximately one hour.

Congratulations, you are now running a SolarCoin full node!

<hr>

#### Using your wallet

This section is still under construction. Stay tuned for future updates!

After the installation, your Pi will synchronize with the blockchain. This will take several days, so be patient. In the meantime you should:

- Download an SSH client (I use PuTTY: http://www.putty.org/)
- Find out your Pi's IP address
- Access your Pi via SSH (login: root - password: solarpi)
- Encrypt your wallet by entering:
> solarcoind encryptwallet **enter your secure passphrase here**
- Backup your wallet with:
> solarcoind backupwallet /destination/directory/of/your/choice/wallet.dat
- Remember that if you lose your wallet or passphrase all of your SLR are lost forever.

You can start using your wallet once your Pi is in sync with the blockchain. For more information on how to use your wallet please refer to this guide:
* https://github.com/Scalextrix/SolarCoin-Raspberry-Pi-Node/blob/master/Useful-SolarCoin-Daemon-Commands.md

#### !!! MAKE SURE TO ENCRYPT YOUR WALLET BEFORE YOU DEPOSIT SLR ON IT !!!

<hr>

#### Credits

SolarPi Copyright (C) 2017 Dominik Schäfer
* domme@solarcoin.mehrunfug.org
* Feel free to send any tips to my SLR address: 8Wrc5DaCFFzPBLsBZsnRtaXnrUygGjm6gJ

Based on the instructions for manual installation by Scalextrix:
* https://github.com/Scalextrix/SolarCoin-Raspberry-Pi-Node

#### License
![GPLv3](http://www.gnu.org/graphics/gplv3-127x51.png)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.
If not, see http://www.gnu.org/licenses/gpl-3.0.html
