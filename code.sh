#!/bin/bash
TIME=`date +%b-%d-%y`
FILENAME=backup-$TIME.tar.gz
SRCDIR=/var/www/html/abcd.com
DESDIR=/backup/CodeBackup/TarBackup/abcd.com

[ -d /backup/CodeBackup/FullBackup/abcd.com ] || mkdir -p /backup/CodeBackup/FullBackup/abcd.com

dest="/backup/CodeBackup/FullBackup/abcd.com"


rsync -avh $SRCDIR/ $dest/

tar -cpzf $DESDIR/$FILENAME $SRCDIR


find /backup/CodeBackup/TarBackup/abcd.com/*   -mtime +30  -exec rm -rf {} \;
