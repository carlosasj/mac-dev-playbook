#!/bin/bash

ANSIBLE_LOCATION="$HOME/Library/Python/3.9/lib/python/site-packages/ansible"

export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH"

# Ask for the administrator password upfront
sudo -v
echo "OK. Continuing..."

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

git --version && pip3 --version

if [[ !( -d $ANSIBLE_LOCATION ) ]]; then
	echo -e "\n\n🏗️ We must first upgrade pip and install ansible"
	sudo pip3 install --upgrade pip
	pip3 install ansible
fi

if [[ !( -f config.yml ) ]]; then
	echo "!!! ❌ No remote config.yml found ❌ !!!"
	echo "!!! Aborting, so we don't install unwanted packages !!!"
	exit 1;
fi;

if [[ -f "$HOME/.work.gitconfig" ]]; then
	ansible-galaxy install -r requirements.work.yml
else
	ansible-galaxy install -r requirements.yml
fi

echo -e "\n\nBECOME username: root"
ansible-playbook min.yml --ask-become-pass -v "$@"
