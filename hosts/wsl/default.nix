{ inputs, ... }:
let
  username = "nixos";
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  system.stateVersion = "24.11";

  wsl = {
    enable = true;
    defaultUser = "${username}";
    docker-desktop.enable = true;
    startMenuLaunchers = true;
    wslConf.user.default = "${username}";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
