{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  networking.hostName = "wsl";

  system.stateVersion = "24.11";
  time.timeZone = "Australia/Sydney";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "x86_64-linux";

  wsl = {
    enable = true;
    docker-desktop.enable = true;
    startMenuLaunchers = true;
    interop.includePath = false; # include windows path
    useWindowsDriver = true;
    nativeSystemd = true;
    # defaultUser = "${username}";
    # wslConf.user.default = "${username}";
  };

  environment.variables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    gcc
    openssl
    gnumake
    gnused
    gnutar
    gnupg
    zip
    unzip
    xz
    file
    which
    tree
    age # file encryption
    sops # secrets manager

    neovim
    wget
    tmux

    wslu

    home-manager

    mpv
    ffmpeg
  ];

  programs = {
    # https://github.com/nix-community/nix-ld
    nix-ld.enable = true;

    zsh.enable = true;

    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
