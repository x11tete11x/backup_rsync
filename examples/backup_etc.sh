#!/bin/bash
########## CONFIG #################
TARGET="backup_etc"
BACKUPDIR="/backup/archivo/"
SRC_RSYNC="/etc/"
DST_RSYNC="/backup/$TARGET/etc"
###################################

DIA=`date +%d`
MES=`date +%m`
ANIO=`date +%Y`
HORA=`date +%H%M%S`
TIMESTAMP="$ANIO$MES$DIA""_""$HORA"
HOSTNAME="$(hostname)"

#Creamos directorios si no existen
mkdir -p "$DST_RSYNC"
mkdir -p "$BACKUPDIR"

RSYNC=$(rsync -atiu $SRC_RSYNC $DST_RSYNC --delete)

#PARA DEBUG
#echo $RSYNC
#/PARA DEBUG

if [ -n "${RSYNC}" ]; then
	#Generamos el Backup
	FILE="$HOSTNAME""-$TARGET-""$TIMESTAMP"".tar.bz2"
	tar -cpjf "$BACKUPDIR""$FILE" "$DST_RSYNC"
	sha256sum "$BACKUPDIR""$FILE" > "$BACKUPDIR""$FILE"".sha256"
else
	echo "RSYNC no produjo cambios"
fi
