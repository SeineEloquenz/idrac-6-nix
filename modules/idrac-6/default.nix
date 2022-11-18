{ config, lib, pkgs, ... }:

with lib;

{

  options.services.idrac-6 = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    host = mkOption {
      type = types.str;
    };
    port = mkOption {
      type = types.str;
    };
    user = mkOption {
      type = types.str;
    };
    secret = mkOption {
      type = types.submodule {
        options = {
          name = mkOption {
            type = types.str;
          };
          owner = mkOption {
            type = types.str;
          };
        };
      };
    };
  };

  config = mkIf config.services.idrac-6.enable {
    sops.secrets.${config.services.idrac-6.secret.name} = {
      owner = config.services.idrac-6.secret.owner;
      path = "/home/${config.services.idrac-6.secret.owner}/.config/idrac-6/pw";
    };
    environment.systemPackages = [
      (pkgs.callPackage ./../../idrac-6.nix {
        iDRAC = config.services.idrac-6;
      })
    ];
  };
}
