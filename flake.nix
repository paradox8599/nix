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

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./hosts
      ];

      # nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      #   system = "${system}";
      #   specialArgs = { inherit inputs system username; };
      #   modules = [
      #     # nixos
      #     nixos-wsl.nixosModules.default
      #     {
      #       environment.systemPackages = with pkgs; [
      #         zip
      #         unzip
      #         nodejs_22
      #         bun
      #         bottom
      #         fd
      #         fzf
      #         jq
      #         ripgrep
      #         sad
      #         yazi
      #         gcc
      #         python312
      #         tmux
      #         cargo
      #         rustc
      #         rustup
      #         lazygit
      #         wget
      #         luarocks
      #         lua-language-server
      #         luajitPackages.lua-lsp
      #         tlrc
      #         nixd
      #         deadnix
      #         alejandra
      #         home-manager
      #       ];
      #
      #       programs = {
      #         neovim = {
      #           enable = true;
      #           defaultEditor = true;
      #           viAlias = true;
      #           vimAlias = true;
      #         };
      #
      #         git = {
      #           enable = true;
      #           config = {
      #             init = { defaultBranch = "main"; };
      #             url = { "https://github.com/" = { insteadOf = [ "gh:" "github:" ]; }; };
      #           };
      #         };
      #       };
      #
      #       systemd.services.wsl-keep-running = {
      #         description = "Keep NixOS-WSL running";
      #         wantedBy = [ "multi-user.target" ];
      #         serviceConfig = {
      #           Type = "simple";
      #           Restart = "always";
      #           ExecStart = "${pkgs.coreutils}/bin/sleep infinity";
      #         };
      #       };
      #     }
      #   ];
      # };
    };
}
