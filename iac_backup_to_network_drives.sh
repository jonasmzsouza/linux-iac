#!/bin/bash

####
# For this script to be successful, you must first carry out the steps mentioned in this comment area.
#
# Create a file '.smbcredentials' with the access credentials to the backup server in the desired directory. 
# In this example, the file was created in the 'root' directory. 
# Insert the lines below without the '#' into the created file.
#
# username=backupuser
# password=1234567
# domain=domain.com
#
# Mapping network drives/automatic assembly of network folders.
# '192.168.0.1' is the backup server. 
# 'backupfolder' is the folder shared by the server.
# '/media/' is the location on the client machine where the folder shared by the server will be mounted. This location contains a directory with the same name as the shared folder.
# Configure the line below in the '/etc/fstab' file.
#
# //192.168.0.1/backupfolder /media/backupfolder cifs credentials=/root/.smbcredentials,iocharset=utf8,gid=0,uid=0,dir_mode=0777,file_mode=0777
#
####

# Variables - Directories
TMPDB=/var/www/backup
SHARED=/media/backupfolder
DIR="$SHARED"/mkt_sites

echo "Create the directory '$TMPDB' if it doesn't exist, otherwise clear the directory '$TMPDB'..."
# -d = diretorio, -f = arquivo
if [ ! -d "$TMPDB" ] ; then
mkdir "$TMPDB"
else
rm -f "$TMPDB"/*
fi

echo "Creating a copy of the database in the '$TMPDB' directory..."
/usr/bin/mysqldump -u db_user -p 'db_password' db_name > "$TMPDB"/Dump_MySQL_sitenameDB-`date +%Y%m%d%H%M%S`.sql

echo "Creating the '$SHARED' directory if it doesn't exist"
if [ ! -d "$SHARED" ] ; then
mkdir "$SHARED"
fi

echo "Mounting the shared folder configured in '/etc/fstab' in the '$SHARED' directory"
sudo mount -a

echo "Creating the '$DIR' directory if it doesn't exist"
if [ ! -d "$DIR" ] ; then
mkdir "$DIR"
fi

echo "Compacting the site and copying the database, and sending it to the mounted folder."
tar zcf "$DIR"/sitename-`date +%Y%m%d%H%M%S`.tar.gz "$TMPDB"/Dump_MySQL_sitenameDB*.sql /var/www/html/site
