{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      (writeShellScriptBin "opencode" ''pnpx opencode-ai "$@"'')
    ];

    file.".config/opencode/opencode.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/configs/opencode/opencode.jsonc";
  };
}
