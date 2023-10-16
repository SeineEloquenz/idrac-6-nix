{ config, lib, pkgs, ... }:
let

  cfg = config.programs.idrac-6;

  jre6 = pkgs.callPackage ./pkgs/jre-6.nix {};
  idrac = pkgs.callPackage ./pkgs/idrac.nix {};

  mkSecretName = host: "idrac-${host.secret}";
  mkSecretPath = host: "/home/${config.home.username}/.config/idrac-6/${host.secret}";

in {

  options.programs.idrac-6 = with lib; {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    hosts = mkOption {
      description = "List of hosts for which to generate iDRAC configurations";
      type = with types; listOf (submodule {
        options = {
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
      });
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets = with lib; listToAttrs (map (host: { name = mkSecretName host; value = { path = mkSecretPath host; }; }) cfg.hosts);
    home.packages = with lib; map (host: pkgs.callPackage ./pkgs/server.nix { inherit jre6 idrac; idracOptions = host // { pwFile = mkSecretPath host; }; }) cfg.hosts;
  };
}
