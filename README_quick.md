# Commands

From: https://github.com/geerlingguy/mac-dev-playbook

```bash
xcode-select --install
```
and Login on iCloud and Mac App Store

**If Work:**
```bash
mkdir ~/.work/ ;
cat > ~/work/.gitconfig << EOL
[user]
  name = Carlos Schneider
  email = carlos.schneider@company.com
EOL
```

**If Work or Peronal:**
```bash
ln -s ~/git/mac-dev-playbook/config.work.yml ~/git/mac-dev-playbook/config.yml
ln -s ~/git/mac-dev-playbook/config.personal.yml ~/git/mac-dev-playbook/config.yml
```

```bash
make install
```
