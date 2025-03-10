{ pkgs, ... }:
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/programs/git.nix
    ../../modules/programs/gitui.nix
    ../../modules/programs/neovim.nix
    ../../modules/programs/starship.nix
    ../../modules/programs/tmux.nix
    ../../modules/programs/zoxide.nix
    ../../modules/programs/zsh.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    ripgrep
    jq
    fzf
    fd
    xxd
    diff-so-fancy
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
    mtr

    # common dev deps
    sqlite
    nodejs_22
    bun
    deno
    python312
    uv

    rustup
    cargo-shuttle
    cargo-binstall
    cargo-cache

    tlrc
    yazi
    sad
    lazygit
    lazydocker
    flyctl
    hyperfine

    # neovim nix plugin pack
    nixd
    deadnix
    alejandra
    nixfmt-rfc-style

    # llm
    shell-gpt
  ];

  programs = {
    home-manager.enable = true;
  };
}
