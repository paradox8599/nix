sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist && sleep 3 && \
sudo nix run --extra-experimental-features "flakes nix-command" nix-darwin/master#darwin-rebuild -- --flake ~/.config/nix#darwin switch
