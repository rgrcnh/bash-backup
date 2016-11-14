#!/bin/bash

#manual script to make incremental backups like MacOSx Time Machine

DATE=`date "+%Y-%m-%d-%H_%M_%S"`

#folder where configuration files are.
CONFOLDER=$PWD
CONFILE=$CONFOLDER/rsync-list
EXCLUDEFILE=$CONFOLDER/rsync-exclude
INCLUDEFILE=$CONFOLDER/rsync-include

#default destination, if not specified on confile
DESTPREFIX=/media/`whoami`/backup/$HOSTNAME


PARAM="-aPFmx --progress --stats --delete --delete-excluded \
 --exclude-from=$EXCLUDEFILE \
 --include-from=$INCLUDEFILE "

# a = -rlptgoD
# r -> recursive, l -> links, p -> preserve links
# t -> preserve modification time
# g -> preserve group, o ->  preserve owners
# m -> prune empty dirs
# z ->  

echo "Select the backup:"


if [ -f "$CONFILE" ]; then
  echo "Reading $CONFILE"
  . $CONFILE
fi

while [ 1 -eq 1 ];
do

  i=0
  for loc in ${dest[*]}; do
    i=$[$i+1]
    echo "$i - ${src[$i]} -> ${dest[$i]}"
  done

  echo "Press s to exit or..."
  echo  -n "Choose the destination: "
  read i  

  if [ "$i" == "s" ]; then
    exit 1
  fi

  if [ -z  "${dest[$i]}" ]; then
    echo "Invalid option!!!"
  fi

  if [ "${users[$i]}" != "$(id -u -n)" ]; then
    echo "You must be a superuser ${users[$i]} to run with this option."
    exit
  fi


  if [ ! -d "${dest[$i]}"  ]; then
    mkdir -p "${dest[$i]}" 
  fi
  if [  -h "${dest[$i]}/current" ]; then
    PARAM="$PARAM --link-dest=../current"
  fi
  echo "Making the backup of ${src[$i]} to folder ${dest[$i]}/backup-$DATE"
  rsync $PARAM ${src[$i]} ${dest[$i]}/incomplete-$DATE \
    && mv ${dest[$i]}/incomplete-$DATE ${dest[$i]}/backup-$DATE \
    && rm -f ${dest[$i]}/current \
    && cd ${dest[$i]} \
    && ln -s backup-$DATE current \
    && cd - 
  if [ "$?" -eq  0 ]; then
    echo "*****************************"
    echo "Backup is done."
    echo "*****************************"
  fi

done

