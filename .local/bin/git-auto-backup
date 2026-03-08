#!/usr/bin/env bash
echo "Git backup start"

# Documents
cd /home/serr/projects/documents/ || exit 1
git -c user.name="Backup Bot" -c user.email="pi@pis.ka" add .
git -c user.name="Backup Bot" -c user.email="pi@pis.ka" commit -m "quick update"
git push

# Dotfiles
cd /home/serr/projects/dotfiles/ || exit 1
git -c user.name="Backup Bot" -c user.email="pi@pis.ka" add .
git -c user.name="Backup Bot" -c user.email="pi@pis.ka" commit -m "quick update"
git push

echo "Git backup end"
