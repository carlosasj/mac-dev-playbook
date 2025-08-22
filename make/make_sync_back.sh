#!/bin/bash

[[ -f /etc/pam.d/sudo_local ]] && cp /etc/pam.d/sudo_local files/sudo/
