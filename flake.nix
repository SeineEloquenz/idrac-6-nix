{
  description = "Integrates sops into nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, sops-nix }:{
    homeManagerModules.idrac-6 = import ./modules/idrac-6;
    homeManagerModule = self.homeManagerModules.idrac-6;
  };
}
