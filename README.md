# Bash Script for backing up two directories

A simple bash script to make a backup of a directory to another one while automatically checking if there is an update to the source directory and updating the backup directory.

## Environment Setup
### Script only 
<p> * Place directories next to each other and the script next to them <br>
 * Run the script and append the inputs (dir , backupdir , maxbackups , intervalsecs)<br>
  <Running in sudo mode will ensure process stability> <br>
 * Scripts executes sucessfully if there is no wrong input and the directory exists <br>
  </p>

### Script with makefile 
<p>* Place directories , script and make file in same folder <br>
  * Run "make" command in the shell <br>
 </p>
 
### cronjob
<p>* Place directories , script and make file in same folder <br>
  1st: user should place his "name" in the cron allow folder
  by doing "sudo cat cron.allow <their-name>" <br>
  2nd: user should run "sudo systemctl status cron.service"
to check if the cron service exists on his machine.
  3rd: if the user wants the script to run each minute he should open the crontab 
by doing "crontab -e" then putting the cronjob in it <br>
  <*/1 * * * * /bin/sh <pathtoscript>/scriptname.sh>
  scriptname would be backupd <br>
   * C) Cron expression would be : 31 00 3 * FRI <br>
 </p>


## Code overview
Code is divided into sections: <br>
1st : variable definition <br>
variables are defined then stored to be processed for validity <br>
 2nd : validtaion of variables <br>
 Validation is run to check for wrong formatted input <br>
 3rd : backup service <br>
 A loop is run with a sleeping period to check for the maximum number of backups and process the backup <br>
## Hirechal view

<img src="view.jpg">
