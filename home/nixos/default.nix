{
  self,
  pkgs,
  ...
}:
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/share/tmux.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # FHS environment
    (import "${self}/modules/share/fhs.nix" { inherit pkgs; })

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

    # required by neovim?
    nodejs_22
    python312
    cargo
    rustc

    # bun
    # rustup

    tlrc
    yazi
    sad
    lazygit
    flyctl

    nixfmt-rfc-style
    lua-language-server
    luajitPackages.lua-lsp
    nixd
    deadnix
    alejandra
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

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      profileExtra = ''
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
      '';

      shellAliases = {
        urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
        urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
        nh = "nix profile history --profile /nix/var/nix/profiles/system";
        lg = "lazygit";
        rb = "sudo nixos-rebuild --flake ~/.config/nixos";
        rbv = "sudo nixos-rebuild --flake ~/.config/nixos --show-trace --print-build-logs --verbose";
        t = ''[[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session -s main'';
        tl = "tmux ls 2>/dev/null";
        j = "z";
        ji = "zi";
        vi = "fhs -c vi";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
