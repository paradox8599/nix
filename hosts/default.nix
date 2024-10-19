{ self
, inputs
, ...
}: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
      specialArgs = { inherit self inputs; };
    in
    {
      nixos = nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;
        modules = [
          ./wsl

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nixos = import "${self}/home/nixos";
          }
        ];
      };
    };
}
