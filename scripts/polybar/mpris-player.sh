#!/bin/sh

player_status=$(~/.nix-profile/bin/playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "󰎇 $(~/.nix-profile/bin/playerctl metadata artist) - $(~/.nix-profile/bin/playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo "󰏤 $(~/.nix-profile/bin/playerctl metadata artist) - $(~/.nix-profile/bin/playerctl metadata title)"
else
    echo ""
fi
