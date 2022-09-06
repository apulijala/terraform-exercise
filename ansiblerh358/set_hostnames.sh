#!/bin/bash 
for machine in servera serverb serverc serverd
do
        ssh  "$machine" groupadd admin
        ssh "$machine" hostnamectl set-hostname "$machine"
        ssh "$machine"  'echo "%admin        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/admin'
        for user in devops student
        do
              ssh "$machine" useradd -G admin "$user"
              ssh "$machine" echo "redhat" | passwd --stdin "$user"
        done
done
