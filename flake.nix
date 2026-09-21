{
  inputs = {
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }: {
    nixosConfigurations.neo = nixpkgs.lib.nixosSystem {
      # needed to have a mix of unstable and stable packages
      specialArgs = {
        inherit inputs;
      };
      modules = [ ./configuration-neo.nix ];
    };
    nixosConfigurations.trinity = nixpkgs.lib.nixosSystem {
      # needed to have a mix of unstable and stable packages
      specialArgs = {
        inherit inputs;
      };
      modules = [ ./configuration-trinity.nix ];
    };
  };
}
