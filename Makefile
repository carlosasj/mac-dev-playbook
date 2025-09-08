install:
	sh make/make_install.sh

refresh:
	sh make/make_refresh.sh

setup_ssh:
	sh make/make_setup_ssh.sh

sync_back:
	sh make/make_sync_back.sh

defaults:
	./files/osx/.osx_defaults

defaults_sudo:
	./files/osx/.osx_defaults_sudo

delicate:
	./files/osx/.osx_delicate

destructive:
	./files/osx/.osx_destructive
