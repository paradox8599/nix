{
  pkgs,
  username,
  stateVersion,
  ...
}:
{
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
    ../../modules/programs/opencode.nix
  ];

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";

    sessionVariables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      (writeShellScriptBin "ccr" ''pnpx @musistudio/claude-code-router "$@"'')
      (writeShellScriptBin "claude" ''pnpx @anthropic-ai/claude-code "$@"'')
      (writeShellScriptBin "gemini" ''pnpx @google/gemini-cli "$@"'')

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
      lazysql
      flyctl
      hyperfine

      nix-output-monitor
      nix-inspect

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

      direnv
      # devenv
      # age # file encryption
      # sops # secrets manager

      # common dev deps
      sqlite
      nodejs_24
      bun
      # deno
      python312
      uv
      pnpm

      # rust
      cargo
      # rustc
      # rustfmt
      # rust-analyzer
      # clippy

      yt-dlp
    ];

  };

}
