#!/bin/bash

[[ -f ~/.config/karabiner/karabiner.json ]] && cp ~/.config/karabiner/karabiner.json ../files/karabiner/karabiner.json
[[ -f /etc/pam.d/sudo_local ]] && cp /etc/pam.d/sudo_local ../files/sudo/sudo_local
