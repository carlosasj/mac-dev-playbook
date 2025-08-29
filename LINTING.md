# Linting Configuration for mac-dev-playbook

This repository uses two linters to maintain code quality:

## 🔧 Tools Installed

- **ansible-lint** (6.22.2) - Lints Ansible playbooks and tasks
- **yamllint** (1.37.1) - Lints YAML files

## 📁 Configuration Files

- `.ansible-lint` - Ansible-lint configuration
- `.yamllint` - YAML lint configuration

## 🚀 Usage

### Run all linters:
```bash
./lint.sh
```

### Run individual linters:
```bash
# YAML linting
yamllint .
yamllint config.personal.yml

# Ansible linting
ansible-lint
ansible-lint tasks/ssh.yml
```

## ⚙️ Configuration Highlights

### ansible-lint
- Excludes external roles (`elliotweiser.*`, `gantsign.*`, `geerlingguy.*`)
- Allows Jinja2 templates in task names for clarity
- Allows shell commands and pipes when needed
- Allows tasks that run when changed without being handlers

### yamllint
- Line length limit: 180 characters
- Allows extra spaces after commas for alignment
- Comment indentation warnings (not errors)
- Allows missing document start (`---`) as warning
- Excludes external role `.github/` directories

## 🔄 Updating Tools

```bash
# Update ansible-lint
python3 -m pip install --user --upgrade ansible-lint

# Update yamllint  
python3 -m pip install --user --upgrade yamllint
```

## 🎯 Integration

The linting configuration is designed to work with your existing code style while catching real issues. The tools are configured to be helpful rather than overly strict.
