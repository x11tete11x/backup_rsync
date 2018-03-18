# backup_rsync
A customizable script that can be executed periodically but only will create a new backup when changes something changes

How it works?
For example this configuration:

```BASH
TARGET="backup_etc"
DIA=`date +%d`
MES=`date +%m`
ANIO=`date +%Y`
HORA=`date +%H%M%S`
TIMESTAMP="$ANIO$MES$DIA""_""$HORA"
HOSTNAME="$(hostname)"
BACKUPDIR="/backup/archivo/"
SRC_RSYNC="/etc/"
DST_RSYNC="/backup/$TARGET/etc"
```
This will kept a copy of /etc in /backup/backup_etc/etc then when the script is executed, rsync will copy /etc to /backup/backup_etc/etc then if rsync return something != 0 the script will generate a backup. Notice that even if you delete something from source, then rsync will produce changes (in this example if you delete something in /etc then rsync will remove it in /backup/backup_etc/etc, that will produce changes, so it will generate a new backup)


