{
  description = "My first flake :)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:

    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      nixosConfigurations = {
        nixos = lib.nixosSystem{
          inherit system;
          modules = [
            ./modules/nixos/default.nix
            ./modules/packages/base.nix
            ./modules/video-driver/nvidia.nix
            ./modules/packages/window-managers.nix
          ];
        };
      };

      homeConfigurations = {
        vex = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./modules/home-manager/home.nix ];
        };
      };
    };
  
}
