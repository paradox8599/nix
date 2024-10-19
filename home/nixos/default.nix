{ pkgs, ... }: {
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    ripgrep
    jq
    fzf
    fd
    nmap
    eza

    # misc
    file
    which
    tree
    gnused
    gnutar
    gnupg
    # zstd

    nix-output-monitor

    glow # markdown previewer in terminal
    fastfetch
    just

    bottom
    iotop # io monitoring
    iftop # network monitoring
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    # system tools
    pciutils # lspci
    usbutils # lsusb

    nodejs_22
    python312
    bun
    # cargo
    # rustc
    # rustup

    tlrc
    yazi
    sad
    lazygit

    lua-language-server
    luajitPackages.lua-lsp
    nixd
    deadnix
    alejandra
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "paradox8599";
    userEmail = "paradox8599@outlook.com";
  };

  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';

    shellAliases = {
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      nixhistory = "nix profile history --profile /nix/var/nix/profiles/system";
      lg = "lazygit";
      rb = "sudo nixos-rebuild --flake ~/.config/nixos";
      rbv = "sudo nixos-rebuild --flake ~/.config/nixos --show-trace --print-build-logs --verbose";

    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
