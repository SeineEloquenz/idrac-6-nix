# idrac-6-nix
This repository provides a nixos Module providing an iDRAC-6 installation for Dell Servers.
Because Dell does not support iDRAC 6 anymore, we need to use a deprecated jdk7 to work around
limitations in iDRAC.

This flake provides a properly patched jdk for iDRAC, as well as integration with sops-nix
for storing secrets.

# How to use
Add to your flake inputs:
```
idrac-6 = {
  url = "github:SeineEloquenz/idrac-6-nix";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.sops-nix.follows = "sops-nix";
};
```
Add to your configuration's modules:
```
idrac-6.nixosModules.idrac-6
```
