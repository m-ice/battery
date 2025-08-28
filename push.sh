#!/bin/zsh
#git pull
git add .
# shellcheck disable=SC2006
git commit -m "提交于`date "+%Y-%m-%d"` 调整内容：$1"
git push -f -u ice_origin 
git push -f -u qd_origin