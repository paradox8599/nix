{ inputs
, pkgs
, ...
}:
let
  username = "nixos";
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  system.stateVersion = "24.11";
  time.timeZone = "Australia/Sydney";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  wsl = {
    enable = true;
    defaultUser = "${username}";
    docker-desktop.enable = true;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    nativeSystemd = true;
    wslConf.user.default = "${username}";
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.${username} = {
    isNormalUser = true;
    linger = true;
  };

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
    home-manager
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
}
