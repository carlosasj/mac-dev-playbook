install:
	sh make/make_install.sh $(ARGS)

refresh:
	sh make/make_refresh.sh $(ARGS)

setup_ssh:
	sh make/make_setup_ssh.sh $(ARGS)

sync_back:
	sh make/make_sync_back.sh $(ARGS)

defaults:
	./files/osx/.osx_defaults $(ARGS)

defaults_sudo:
	./files/osx/.osx_defaults_sudo $(ARGS)

delicate:
	./files/osx/.osx_delicate $(ARGS)

destructive:
	./files/osx/.osx_destructive $(ARGS)
