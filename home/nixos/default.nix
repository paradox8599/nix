{ pkgs, ... }:
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/programs/aider.nix
    ../../modules/programs/direnv.nix
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
    tlrc
    yazi
    dust
    sad
    lazygit
    lazydocker
    flyctl
    hyperfine

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

    devenv
    direnv
    cachix
    # age # file encryption
    # sops # secrets manager

    # common dev deps
    sqlite
    nodejs_22
    bun
    deno
    python312
    uv

    # rust
    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy

    # neovim nix plugin pack
    nixd
    deadnix
    alejandra
    nixfmt-rfc-style

    # llm
    shell-gpt
  ];
}
