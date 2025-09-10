#!/bin/bash

export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH"

git --version && pip3 --version

if [[ !( -f config.yml ) ]]; then
	echo "!!! ❌ No remote config.yml found ❌ !!!"
	echo "!!! Aborting, so we don't install unwanted packages !!!"
	exit 1;
fi;

# Ask for the administrator password upfront
sudo -v
echo "OK. Continuing..."

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo -e "\n\nBECOME username: root"
# echo -e   "BECOME password: "

ansible-playbook main.yml --ask-become-pass -v "$@"
