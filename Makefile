.ONESHELL:
dir= "backup"
backupdir= "backupdiwsdar"
maxbackups= 3
intervalsecs= 4

all: prebuild

prebuild:
	@if [ ! -d $(backupdir) ] 
	@then
	    @echo "Alert: $(backupdir) doesn't exist"
	    @echo "Creating new directory at $(backupdir) ..."
	    @mkdir -p $(backupdir)
	@fi
	@sudo bash backupd.sh $(dir) $(backupdir) $(maxbackups) $(intervalsecs); \