# NixOS

## Getting Started

## nix-darwin

```sh
sudo nix run --extra-experimental-features "flakes nix-command" nix-darwin/master#darwin-rebuild -- --flake ~/.config/nix#darwin switch
```
