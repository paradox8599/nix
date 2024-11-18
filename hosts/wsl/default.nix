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

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    openssl

    zip
    unzip
    xz

    wget
    tmux

    wslu

    home-manager

    mpv
    ffmpeg
  ];

  programs = {
    zsh.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
        url = {
          "git@github.com:" = {
            insteadOf = [ "gh:" ];
          };
          "https://github.com/" = {
            insteadOf = [ "github:" ];
          };
        };
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
