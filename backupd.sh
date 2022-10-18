#!/usr/bin/bash

parameters=$*

number=$#

time=$(date '+%Y-%m-%d-%H-%M-%S')

error_parameters="Please specify only 4 arguments.

\nYou need to specify [dir , backupdir , interval-secs , maxbackups]

\ndir : the source directory that have list of file we need to backup.

\nbackupdir : the destination directory that will have the backup

\ninterval-secs : time to wait between every check

\nmax-backups : maximum number of backups need to be reserved."


if [[ $number -lt 4 ]] || [[ $number -gt 4 ]]
then
echo -e $error_parameters
exit
fi

dir=$1
backupdir=$2
intervalsecs=$3
maxbackups=$4


# Check For directory
if [ -d "$dir" ]
then
  echo -e "Found directory....
  \nContinuing...."
  echo
else
  echo "Error: ${dir} doesn't exist"
  exit 1
fi

# Check for Backup directory
if [ -d "$backupdir" ]
then
  echo -e "Backup directory exists....
  \n Continuing...."
  echo
else
#create directory
  echo "Alert: ${backupdir} doesn't exist"
  echo "Creating new directory at ${backupdir}..."
  mkdir -p $backupdir
fi

regex='^[0-9]+$'
if ! [[ $intervalsecs =~ $regex ]] ; 
then
   echo "Error: Interval secs is a number"
   exit 1
fi

regex='^[0-9]+$'
if ! [[ $maxbackups =~ $regex ]] ;
then
   echo "Error: maxbackups secs is a number"
   exit 1
fi

if [ $intervalsecs -lt 0 ];
then
echo "Error : intervalsecs should be a postive number"
exit 1
fi


##### intial info
source="sudo ls -lR $dir > info.last" 
eval $source
###### initial backup
cp -r --backup $dir $backupdir/$time
#####
touch info.new;

while [ 1 ]
do
    sleep $intervalsecs;
    time=$(date '+%Y-%m-%d-%H-%M-%S')

    sudo ls -lR $dir > info.new; 
  

if cmp -s "info.new" "info.last"; then
    echo -e "Same files.... \n
    No new backups in order."
    continue
    
    
    
else
    cd ${backupdir}
    if  [ $(ls | wc -l) -ge ${maxbackups} ]  
    then
        echo "Deleting the least recent backup.... "
        rm -r $(ls -r | tail  -n 1)
        fi
        cd ..
        echo -e "Diffrent files... \n
        Intiating backup..."
        mkdir -p $backupdir/$time
        cp -r --backup $dir $backupdir/$time
        source="sudo ls -lR $dir > info.last"
        eval $source
        cp info.last info.new
fi
done
