install:
	sh make/make_install.sh

refresh:
	sh make/make_refresh.sh

setup_ssh:
	sh make/make_setup_ssh.sh

sync_back:
	sh make/make_sync_back.sh

defaults:
  sh files/osx/.osx_defaults

sudo_defaults:
  sh files/osx/.osx_sudo_defaults

be_careful:
  sh files/osx/.osx_be_careful

