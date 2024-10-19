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
      wsl =
        let
          hostname = "wsl";
        in
        nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs // { inherit hostname; };
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
