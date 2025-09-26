{
  pkgs,
  username,
  stateVersion,
  ...
}:
{
  imports = [
    ../../modules/packages/general.nix

    ../../modules/programs/aider.nix
    ../../modules/programs/direnv.nix
    ../../modules/programs/git.nix
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

    packages = with pkgs; [
      (writeShellScriptBin "xclip" ''cat | /mnt/c/Windows/System32/clip.exe'')
    ];

  };

}
