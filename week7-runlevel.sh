#!/bin/bash
#Week 7 Run Level - Lucas Merriott 

# According to my research Archlinux doesnt have runlevels.
# It uses systemd which uses targets.
# https://wiki.archlinux.org/index.php/systemd#Targets

systemctl list-units --type=target
