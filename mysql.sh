MyUSER="root"     # USERNAME
MyPASS='passowrd'       # PASSWORD
MyHOST="localhost"          # Hostname

# Backup Dest directory, change this if you have someother location
MBD="/backup/Mysql_bakups"


# Get data in dd-mm-yyyy format
NOW="$(date +"%d-%m-%Y")"

[ ! -d $MBD ] && mkdir -p $MBD || :


# Get all database list first
DBS="$(mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse 'show databases'|grep -Ev 'performance_schema|information_schema|mysql')"

for db in $DBS
do
        [ ! -d $MBD/$db ] && mkdir $MBD/$db
        FILE="$MBD/$db/$NOW.gz"
        FILE3="$MBD/$db/${NOW}_nodata.gz"
        find $MBD/$db/* -mtime +30 -exec rm -rf {} \;
        echo $db
        mysqldump -u $MyUSER -h $MyHOST -p$MyPASS $db | gzip -9 > $FILE
        mysqldump -u $MyUSER --no-data -h $MyHOST -p$MyPASS  $db | gzip -9 > $FILE3
done

rsync -avrh /var/lib/mysql/bin-log/ $MBD

