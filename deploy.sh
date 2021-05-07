
git add .
git commit -m "added things"
git push

ssh ozavodny@genji 'cd ~/infra ; git pull ; sudo nixos-rebuild switch'

