{ config, lib, pkgs, ... }:

{

  options.programs.idrac-6 = with lib; {
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

  config = lib.mkIf config.programs.idrac-6.enable {
    sops.secrets.${config.programs.idrac-6.secret} = {
      path = "/home/${config.home.username}/.config/idrac-6/pw";
    };
    home.packages = [
      (pkgs.callPackage ./package.nix {
        iDRAC = config.programs.idrac-6;
      })
    ];
  };
}
