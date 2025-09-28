{ config, ... }:
{
  programs.wezterm = {
    enable = true;
  };

  home.file.".wezterm.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/configs/wezterm/wezterm.lua";
}
