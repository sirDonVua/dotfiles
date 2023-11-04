{
  description = "My first flake :)";

  inputs = {
      nixpkgs.url = "nixpkgs/nixos-23.05";
  };

  outputs = { self,nixpkgs, ... } :
    let
      lib = nixpkgs.lib
    in {
    nixosconfigurations = {
      nixos = lib.nixosSystem{
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
  
}
