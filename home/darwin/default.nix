{
  pkgs,
  username,
  stateVersion,
  ...
}:
{
  imports = [
    ../../modules/packages/general.nix

    ../../modules/programs/zsh.nix
    ../../modules/programs/tmux.nix
    ../../modules/programs/direnv.nix
    ../../modules/programs/git.nix
    ../../modules/programs/neovim.nix
    ../../modules/programs/starship.nix
    ../../modules/programs/zoxide.nix
    ../../modules/programs/aider.nix
    ../../modules/programs/opencode.nix
  ];

  home = {
    inherit username stateVersion;
    homeDirectory = "/Users/${username}";

    sessionVariables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };

    packages = with pkgs; [
      # user packages
    ];
  };

}
