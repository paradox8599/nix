{
  inputs,
  pkgs,
  ...
}:
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/share/tmux.nix
    ../../modules/share/zsh.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    ripgrep
    jq
    fzf
    fd
    nmap
    eza

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
    mitmproxy

    # common dev deps
    sqlite
    nodejs_22
    # bun
    inputs.nixpkgs-master.legacyPackages."x86_64-linux".bun
    deno
    python312
    rustup
    # cargo
    # rustc
    # rust-analyzer
    # rustfmt
    # clippy

    tlrc
    yazi
    sad
    lazygit
    lazydocker
    flyctl
    hyperfine

    # lua-language-server
    # luajitPackages.lua-lsp

    # neovim nix plugin pack
    nixd
    deadnix
    alejandra
    nixfmt-rfc-style
  ];

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "paradox8599";
      userEmail = "paradox8599@outlook.com";
    };

    starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;

      # plugins = [ ];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
