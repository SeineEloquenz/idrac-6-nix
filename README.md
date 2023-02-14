# idrac-6-nix
This repository provides a nixos Module providing an iDRAC-6 installation for Dell Servers.
Because Dell does not support iDRAC 6 anymore, we need to use a deprecated jdk7 to work around
limitations in iDRAC.

This flake provides a properly patched jdk for iDRAC, as well as integration with sops-nix
for storing secrets.

# Dependencies
To use this flake you will also need to use `sops-nix` and `home-manager`.

# How to use
Add to your flake inputs:
```
idrac-6 = {
  url = "github:SeineEloquenz/idrac-6-nix";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
Add to your home manager modules:
```
idrac-6.homeManagerModule
```
Example module usage:
```
services.idrac-6 = {
  enable = true;
  host = "1.1.1.1";
  port = "5900";
  user = "root";
  secret = "idrac-6";
};
```
Note:
For this configuration to work, you need to add a `idrac-6` secret to sops-nix.
The secret will then be mapped to the user's `.config` directory.
