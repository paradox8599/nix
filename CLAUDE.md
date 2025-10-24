# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Applying Configuration Changes

*   **macOS (darwin):** To apply changes to the macOS configuration, run:
    ```sh
    darwin-rebuild switch --flake .#darwin
    ```

*   **NixOS (WSL):** To apply changes to the NixOS configuration on WSL, run:
    ```sh
    sudo nixos-rebuild switch --flake .#wsl
    ```

### Updating Flake Inputs

To update all the flake inputs (dependencies) to their latest versions, run:

```sh
nix flake update
```

### Garbage Collection

To manually run garbage collection and remove old, unused Nix store paths, run:

```sh
nix-collect-garbage -d
```

## Code Architecture

This repository uses [Nix Flakes](https://nixos.wiki/wiki/Flakes) to manage system configurations for both macOS (`nix-darwin`) and NixOS (on WSL). The configuration is structured using [`flake-parts`](https://github.com/hercules-ci/flake-parts) to make it more modular and maintainable.

### Core Structure

*   `flake.nix`: The main entry point for the flake. It defines all the inputs (dependencies) like `nixpkgs`, `home-manager`, and `nix-darwin`. It then uses `flake-parts` to import the main configuration from `hosts/default.nix`.

*   `hosts/default.nix`: This file defines the main outputs of the flake:
    *   `darwinConfigurations.darwin`: The configuration for macOS systems.
    *   `nixosConfigurations.wsl`: The configuration for NixOS running on WSL.

    For each configuration, it specifies the system-specific modules and integrates `home-manager` for user-specific settings.

*   `hosts/darwin/` and `hosts/wsl/`: These directories contain the system-specific NixOS/darwin modules. For example, `hosts/darwin/default.nix` sets macOS-specific options like `system.stateVersion`, `nix` settings, and `homebrew` integration.

*   `home/`: This directory contains the `home-manager` configurations for different users/systems.
    *   `home/darwin/default.nix`: Defines the user environment for macOS, including packages, shell configuration (zsh), and other user-specific dotfiles.
    *   `home/wsl/default.nix`: Defines the user environment for the WSL/NixOS system.

*   `modules/`: This directory is intended for reusable Nix modules that can be imported into different system configurations. For example, you might find modules for specific services like `podman.nix`.
