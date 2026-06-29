{
  inputs = {
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.neo = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration-neo.nix ];
    };
    nixosConfigurations.trinity = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration-trinity.nix ];
    };
  };
}
