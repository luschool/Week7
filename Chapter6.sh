#!/bin/bash
#Week 6 Chapter 6 Script - Lucas Merriott 
#I submitted it last week as well but it seems I got ahead of myself and 
#it wasnt due until this week.

# It will prompt you for your password multiple times so it can perform sudo commands


echo Your System Unit directory is -
pkg-config systemd --variable=systemdsystemunitdir

echo Your System Config directory is -
pkg-config systemd --variable=systemdsystemconfdir

echo


#now lets make a 2 test units. One will depend on the other.
cd /etc/systemd/system

sudo touch test1.target
sudo touch test2.target

# I couldnt get a normal sudo echo >> test1.target to work so I had to dig around
#to find out how to append text into a root owned file.

echo "[Unit]" | sudo tee -a test1.target
echo "Description=test 1" | sudo tee -a test1.target

echo "[Unit]" | sudo tee -a test2.target
echo "Description=test 2" | sudo tee -a test2.target
echo "Wants=test1.target" | sudo tee -a test2.target

systemctl status test1.target test2.target

#Since Unit test2 depends on test1 if I start test2 only it should start test1 too
echo
echo ------Now I will start test2.target and see if the dependency works------
echo

systemctl start test2.target

#now we will run the status command again

systemctl status test1.target test2.target

# now time to disbale the unit and remove them

systemctl stop test1.target test2.target
systemctl disable test1.target test2.target
sudo rm test1.target test2.target
systemctl daemon-reload

echo All test unit files created by this script have been stopped and removed.
