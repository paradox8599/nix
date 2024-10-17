{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-wsl
    , ...
    }: {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules =
            let
              pkgs = nixpkgs.legacyPackages.${system};
              username = "nixos";
            in
            [
              nixos-wsl.nixosModules.default
              # configuration.nix
              {
                system.stateVersion = "24.05";
                nix.settings.experimental-features = [ "nix-command" "flakes" ];

                wsl.enable = true;
                wsl.defaultUser = "${username}";
                wsl.docker-desktop.enable = true;
                wsl.startMenuLaunchers = true;
                wsl.wslConf.user.default = "${username}";

                environment.systemPackages = with pkgs; [
                  neovim
                  git
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
                      url = {
                        "https://github.com/" = {
                          insteadOf = [ "gh:" "github:" ];
                        };
                      };
                    };
                  };
                };

                services.openssh = {
                  enable = true;
                };

                systemd.services.wsl-keep-running = {
                  description = "Keep NixOS-WSL running";
                  wantedBy = [ "multi-user.target" ];
                  serviceConfig = {
                    Type = "simple";
                    ExecStart = "${pkgs.coreutils}/bin/sleep infinity";
                    Restart = "always";
                  };
                };
              }
            ];
        };
      };
    };
}
