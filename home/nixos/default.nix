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
      enable = false;
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
          selected_tab: Reset,
          command_fg: White,
          selection_bg: Blue,
          selection_fg: White,
          cmdbar_bg: Blue,
          cmdbar_extra_lines_bg: Blue,
          disabled_fg: DarkGray,
          diff_line_add: Green,
          diff_line_delete: Red,
          diff_file_added: LightGreen,
          diff_file_removed: LightRed,
          diff_file_moved: LightMagenta,
          diff_file_modified: Yellow,
          commit_hash: Magenta,
          commit_time: LightCyan,
          commit_author: Green,
          danger_fg: Red,
          push_gauge_bg: Blue,
          push_gauge_fg: Reset,
          tag_fg: LightMagenta,
          branch_fg: LightYellow,
        )
      '';
    };
  };
}
