# NixOS

## Getting Started

## nix-darwin

### init install

```sh
sudo nix run --extra-experimental-features "flakes nix-command" nix-darwin/master#darwin-rebuild -- --flake ~/.config/nix#darwin switch
```

### start nix daemon

```sh
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
```

> /run/current-system/sw/bin/darwin-rebuild

