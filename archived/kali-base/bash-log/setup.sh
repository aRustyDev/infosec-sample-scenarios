#!/bin/bash
for user in $@
do
    # Grab homedir based on username
    homedir=$(getent passwd $user | cut -d: -f6)
    # Only run once for a given user
    if [ ! -f $homedir/.bash-log.done ]; then
        # Needed so that chsh work properly
        sed -i 's/auth       required   pam_shells.so/auth       sufficient   pam_shells.so/'  /etc/pam.d/chsh
        chsh -s /bin/bash-log $user
        sed -i 's/auth       sufficient   pam_shells.so/auth       required   pam_shells.so/'  /etc/pam.d/chsh
        # Immediate write of bash history 
        echo "shopt -s histappend" >> $homedir/.bashrc
        echo 'PROMPT_COMMAND="history -a;$PROMPT_COMMAND"' >> $homedir/.bashrc
        # Write a canary file to avoid setting up a user twice
        touch $homedir/.bash-log.done
    fi
done
