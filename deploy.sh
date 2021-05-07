
git add .
git commit -m "added things"

echo -e "\nPushing...\n"

git push

ssh ozavodny@genji 'cd ~/infra ; echo -e "\nPulling...\n" ; git pull ; echo -e "\nSwitching...\n" ; sudo nixos-rebuild switch'
