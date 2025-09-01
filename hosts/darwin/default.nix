{
  inputs,
  pkgs,
  username,
  ...
}: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # networking.hostName = "darwin";
  time.timeZone = "Australia/Sydney";

  nix = {
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
      };
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        "root"
        username
      ];
    };
  };

  environment.variables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    #
  ];

  programs = {
    # https://github.com/nix-community/nix-ld
    # nix-ld.enable = true;

    zsh.enable = true;

    # git = {
    #   enable = true;
    #   config = {
    #     init = {
    #       defaultBranch = "main";
    #     };
    #   };
    # };
  };
}
