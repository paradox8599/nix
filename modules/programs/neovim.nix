{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # nix plugin pack
    nixd
    deadnix
    alejandra
    nixfmt-rfc-style
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
