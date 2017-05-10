#!/bin/bash
# 
# 1. Move all target dotfile to '/path/to/dotfile/'
# 2. git add all
# 3. git commit
#
#

echo 'Syncing dotifles'

cp ~/.vimrc vim/vimrc 
cp ~/.zshrc zsh/zshrc
cp -R ~/.zshsup zsh/zshsup

git add .


DATE_WITH_TIME=`date "+%Y%m%d%H%M%S"`
git commit -m "Auto syncing: $DATE_WITH_TIME"

echo 'Git commit'

git push

echo 'Push complete.'
