#!/bin/bash

export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH"

git --version && pip3 --version

if [[ !( -f config.yml ) ]]; then
	echo "!!! ❌ No remote config.yml found ❌ !!!" 
	echo "!!! Aborting, so we don't install unwanted packages !!!" 
	exit 1;
fi;

echo -e "\n\nBECOME username: root"
ansible-playbook main.yml --ask-become-pass --tags post
