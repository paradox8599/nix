{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixos-wsl
    , home-manager
    , ...
    }:
    let
      system = "x86_64-linux";
      stateVersion = "24.11";
      username = "nixos";
      hostname = "nixos";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = { inherit inputs system username; };
        modules = [
          home-manager.nixosModules.default

          # home-manager
          home-manager.nixosModules.home-manager
          {
            nix.registry.nixos.flake = inputs.self;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }

          # nixos
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "${stateVersion}";
            time.timeZone = "Australia/Sydney";
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            nixpkgs.config.allowUnfree = true;

            wsl.enable = true;
            wsl.defaultUser = "${username}";
            wsl.docker-desktop.enable = true;
            wsl.startMenuLaunchers = true;
            # Which user to start commands in this WSL distro as
            wsl.wslConf.user.default = "${username}";

            environment.systemPackages = with pkgs; [
              zip
              unzip
              nodejs_22
              bun
              bottom
              fd
              fzf
              jq
              ripgrep
              sad
              yazi
              gcc
              python312
              tmux
              cargo
              rustc
              rustup
              lazygit
              wget
              luarocks
              lua-language-server
              luajitPackages.lua-lsp
              tlrc
              nixd
              deadnix
              alejandra
            ];

            programs = {
              neovim = {
                enable = true;
                defaultEditor = true;
                viAlias = true;
                vimAlias = true;
              };

              git = {
                enable = true;
                config = {
                  init = { defaultBranch = "main"; };
                  url = { "https://github.com/" = { insteadOf = [ "gh:" "github:" ]; }; };
                };
              };
            };

            systemd.services.wsl-keep-running = {
              description = "Keep NixOS-WSL running";
              wantedBy = [ "multi-user.target" ];
              serviceConfig = {
                Type = "simple";
                Restart = "always";
                ExecStart = "${pkgs.coreutils}/bin/sleep infinity";
              };
            };

            home-manager.users.${username} = {
              home.stateVersion = "${stateVersion}";
              home.packages = [ ];
              programs = { };
            };
          }
        ];
      };
    };
}
