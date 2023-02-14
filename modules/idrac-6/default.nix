{ config, lib, pkgs, ... }:

{

  options.services.idrac-6 = with lib; {
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
      type = types.str;
    };
  };

  config = lib.mkIf config.services.idrac-6.enable {
    sops.secrets.${config.services.idrac-6.secret} = {
      path = "/home/${config.home.username}/.config/idrac-6/pw";
    };
    home.packages = [
      (pkgs.callPackage ./../../idrac-6.nix {
        iDRAC = config.services.idrac-6;
      })
    ];
  };
}
