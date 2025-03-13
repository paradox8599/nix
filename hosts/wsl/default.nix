{
  inputs,
  pkgs,
  username,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];
  networking.hostName = "wsl";
  system.stateVersion = "24.11";
  time.timeZone = "Australia/Sydney";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # allows devenv to set cachix
      trusted-users = [
        "root"
        username
      ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  wsl = {
    enable = true;
    docker-desktop.enable = true;
    startMenuLaunchers = true;
    interop.includePath = false; # include windows path
    useWindowsDriver = true;
    # defaultUser = "${username}";
    # wslConf.user.default = "${username}";
  };

  environment = {
    variables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };

    systemPackages = with pkgs; [
      gcc
      pkg-config
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

      neovim
      wget
      tmux

      wslu

      home-manager

      mpv
      ffmpeg
    ];

  };

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

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = "no";
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.${username}.openssh.authorizedKeys.keyFiles = [
      ../../configs/ssh/authorized_keys
    ];
  };
}
