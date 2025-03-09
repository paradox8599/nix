{ pkgs, ... }:
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

    gitui = {
      enable = true;
      keyConfig = ''
        (
          open_help: Some(( code: F(1), modifiers: "")),

          move_left: Some(( code: Char('h'), modifiers: "")),
          move_right: Some(( code: Char('l'), modifiers: "")),
          move_up: Some(( code: Char('k'), modifiers: "")),
          move_down: Some(( code: Char('j'), modifiers: "")),

          popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
          popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
          page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
          page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
          home: Some(( code: Char('g'), modifiers: "")),
          end: Some(( code: Char('G'), modifiers: "SHIFT")),
          shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
          shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

          edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

          status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

          diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
          diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

          stashing_save: Some(( code: Char('w'), modifiers: "")),
          stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

          stash_open: Some(( code: Char('l'), modifiers: "")),

          abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
        )
      '';
      theme = ''
        (
          selected_tab: Some("Blue"),
          command_fg: Some("White"),
          selection_bg: Some("Blue"),
          selection_fg: Some("#ffffff"),
          cmdbar_bg: Some("#2e3440"),
          cmdbar_extra_lines_bg: Some("#3b4252"),
          disabled_fg: Some("#4c566a"),
          diff_line_add: Some("#a3be8c"),
          diff_line_delete: Some("#bf616a"),
          diff_file_added: Some("#8fbcbb"),
          diff_file_removed: Some("#d08770"),
          diff_file_moved: Some("#b48ead"),
          diff_file_modified: Some("#ebcb8b"),
          commit_hash: Some("#b48ead"),
          commit_time: Some("#88c0d0"),
          commit_author: Some("#a3be8c"),
          danger_fg: Some("#bf616a"),
          push_gauge_bg: Some("#5e81ac"),
          push_gauge_fg: Some("#eceff4"),
        )
      '';
    };
  };
}
