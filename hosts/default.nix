{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
    let
      username = "nixos";
      stateVersion = "25.05";
      specialArgs = { inherit inputs username stateVersion; };
    in
    {
      wsl = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./wsl/default.nix
          ../modules/services/podman.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${username} = import "${self}/home/nixos";
          }
        ];
      };
    };
}
