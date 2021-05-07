
git add .
git commit -m "added things"
git push

ssh ozavodny@genji 'cd ~/new_infra ; git pull ; sudo nixos-rebuild switch'

