#!/bin/bash

#set -ue

DEFAULT_GROUPS='adm,wheel,kvm,render,video,docker'
DEFAULT_UID='1000'

echo '  __  __ __  __ ___    ___ ___  ___  _   _ ___  '
echo ' |  \/  |  \/  | _ \  / __| _ \/ _ \| | | | _ \ '
echo ' | |\/| | |\/| |   / | (_ |   / (_) | |_| |  _/ '
echo ' |_|  |_|_|  |_|_|_\  \___|_|_\\___/ \___/|_|   '
echo ''
echo 'Welcome to Arch Linux on WSL.'
printf 'This image is built by MMR Group. Please read README \e[0;31mcarefully\e[0m.\n'
echo ''
echo 'Please create a default UNIX user account. The username does not need to match your Windows username.'
echo 'For more information visit: https://aka.ms/wslusers'

if getent passwd "$DEFAULT_UID" > /dev/null ; then
  echo 'User account already exists, skipping creation'
  exit 0
fi

while true; do

  # Prompt from the username
  read -p 'Enter new UNIX username: ' username

  # Create the user
  if /usr/sbin/useradd --uid "$DEFAULT_UID" -m "$username"; then
    passwd "$username"
    ret=$?
    if [[ $ret -ne 0 ]]; then
      /usr/sbin/userdel -r "$username"
      continue
    fi
    if /usr/sbin/usermod "$username" -aG "$DEFAULT_GROUPS"; then
      break
    else
      /usr/sbin/userdel -r "$username"
    fi
  fi
done

echo ''

printf '\e[0;36m[*]\e[0m Generating locales.\n'
/usr/bin/locale-gen
printf '\e[0;36m[*]\e[0m Executing command "pacman-key --init"\n'
pacman-key --init
printf '\e[0;36m[*]\e[0m Executing command "pacman-key --populate"\n'
pacman-key --populate

/usr/local/bin/mmr-gen-frpc "$username"
loginctl enable-linger "$username"
install -d -m 700 -o 1000 -g 1000 /run/user/1000
runuser -l "$username" -c 'systemctl --user daemon-reload'
runuser -l "$username" -c 'systemctl --user enable --now frpc.service'

printf '\e[0;36m[*]\e[0m Start docker service.\n'
sudo systemctl enable --now docker.service docker.socket

printf '\e[0;92mDone! This Arch Linux on WSL installation is ready to use.\e[0m\n'
