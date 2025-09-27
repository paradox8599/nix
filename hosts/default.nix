{
  self,
  inputs,
  ...
}:
let
  stateVersion = "25.05";
in
{
  flake.nixosConfigurations =
    let
      username = "nixos";
      specialArgs = { inherit self inputs username stateVersion; };
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
            home-manager.users.${username} = import "${self}/home/wsl";
          }
        ];
      };
    };

  flake.darwinConfigurations =
    let
      username = "para";
      specialArgs = { inherit self inputs username stateVersion; };
    in
    {
      darwin = inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = [
          ./darwin/default.nix
          inputs.mac-app-util.darwinModules.default

          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${username} = import "${self}/home/darwin";
            home-manager.sharedModules = [
              inputs.mac-app-util.homeManagerModules.default
            ];
          }
        ];
      };
    };
}
