
git add .
git commit -m "added things"

echo -e "\nPushing...\n\n"

git push

ssh ozavodny@genji 'cd ~/infra ; echo -e "\Pulling...\n\n" ; git pull ; echo -e "\Switching...\n\n" ; sudo nixos-rebuild switch'
