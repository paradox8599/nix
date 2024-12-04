{ pkgs, ... }:
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/share/tmux.nix
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
    nodejs_22
    bun
    python312
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy
    sqlite
    # rustup

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

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      profileExtra = ''
        # yazi set cwd when navigate
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }

        export SOPS_AGE_KEY_FILE=~/.config/sops/age.key
      '';

      shellAliases = {
        ls = "exa";
        l = "exa --long --icons --sort=type --group";
        la = "l --all";
        ll = "l --header";
        nh = "nix profile history --profile /nix/var/nix/profiles/system";
        lg = "lazygit";
        ldk = "lazydocker";
        rb = "sudo nixos-rebuild --flake ~/.config/nixos";
        rbv = "sudo nixos-rebuild --flake ~/.config/nixos --show-trace --print-build-logs --verbose";
        t = ''[[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session -s main'';
        tl = "tmux ls 2>/dev/null";
        j = "z";
        ji = "zi";
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
