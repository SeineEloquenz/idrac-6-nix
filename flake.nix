{
  description = "Integrates sops into nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix }:{
    nixosModules.idrac-6 = import ./modules/idrac-6;
    nixosModules.default = self.nixosModules.idrac-6;
  };
}
