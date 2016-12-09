# Small bash script to backup folders

This script uses incremental backups with hard links, pretty like TimeMachine.

## Instructions:

1 - Clone the repo:
```
git clone https://github.com/rgrcnh/bash-backup.git
```
2 -  Configure:

rsync-file, rsync-include and exclude shoud reside inside the same scrit folder, then...
. Edit rsync-file and add origem and destinations and needed permission.
. Edit rsync-include and rsync-exclude to include/exlude file and folders
. Set the script executable:

```
chmod +x backup.sh 
```

3 - Execute the script and follow the screen menu.
```
./bachup.sh 
```
