{ self, inputs, ... }:
{
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
      specialArgs = {
        inherit self inputs;
      };
    in
    {
      wsl =
        let
          username = "nixos";
          args = {
            inherit username;
          };
        in
        nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs // args;
          modules = [
            ./wsl

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import "${self}/home/${username}";
            }
          ];
        };
    };
}
