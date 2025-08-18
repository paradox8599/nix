{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      (writeShellScriptBin "opencode" ''pnpx opencode-ai "$@"'')
    ];

    file.".config/opencode/opencode.jsonc" = {
      enable = true;
      source = ../../configs/opencode/opencode.jsonc;
    };
  };
}
