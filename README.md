= Small bash script to backup folders

this script use incremental backups with hard links, pretty like TimeMachine.

== Instructions:

* Clone the repo:
```
git clone https://github.com/rgrcnh/bash-backup.git
```
* Use:

edit rsync-file and add origem and destionations and needed permission.
edit rsync-include and rsync-exclude to include/exlude file and folders

Set the script executable and run it. Follow the screen instructions:
```
chmod +x backup.sh
./bachup.sh 
```

