#!/bin/sh
sudo apt-get update
sudo apt-get install figlet
sudo apt-get install pv
sudo apt-get install cgpt
sudo bash chromeos-install.sh -src rammus_recovery.bin -dst /dev/sda
#sudo bash chromeos-install.sh -src sammus_recovery.bin -dst /dev/sda
