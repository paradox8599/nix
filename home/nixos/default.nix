{ pkgs, ... }:
{
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

    nixfmt-rfc-style
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      nixhistory = "nix profile history --profile /nix/var/nix/profiles/system";
      lg = "lazygit";
      rb = "sudo nixos-rebuild --flake ~/.config/nixos";
      rbv = "sudo nixos-rebuild --flake ~/.config/nixos --show-trace --print-build-logs --verbose";
      t = ''[[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session -s main'';
      tl = "tmux ls 2>/dev/null";
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
