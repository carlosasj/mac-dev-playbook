#!/bin/bash
# Linting script for mac-dev-playbook

set -e

echo "🔍 Running linters on mac-dev-playbook..."
echo ""

# Change to the correct directory
cd "$(dirname "$0")"

# Run yamllint
echo "📄 Running yamllint..."
yamllint . || echo "⚠️  yamllint found some issues"
echo ""

# Run ansible-lint
echo "🎭 Running ansible-lint..."
ansible-lint || echo "⚠️  ansible-lint found some issues"
echo ""

echo "✅ Linting complete!"
