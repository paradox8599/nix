{
  pkgs,
  username,
  stateVersion,
  ...
}:
{
  imports = [
    # ../../modules/programs/aider.nix
    ../../modules/programs/direnv.nix
    ../../modules/programs/git.nix
    ../../modules/programs/neovim.nix
    ../../modules/programs/starship.nix
    ../../modules/programs/tmux.nix
    ../../modules/programs/zoxide.nix
    # ../../modules/programs/zsh.nix
    # ../../modules/programs/opencode.nix
  ];

  home = {
    inherit username stateVersion;
    homeDirectory = "/Users/${username}";

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

      # glow # markdown previewer in terminal
      fastfetch
      bottom
      iftop # network monitoring
      lsof # list open files

      pciutils # lspci
      # usbutils # lsusb
      # mitmproxy
      mtr

      direnv
      # just
      # age # file encryption
      # sops # secrets manager

      sqlite
      nodejs_24
      bun
      pnpm
      uv
      python313
      cargo
      yt-dlp
    ];
  };

}
