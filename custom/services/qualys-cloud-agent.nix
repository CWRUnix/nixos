# see https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/security/fail2ban.nix for example
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.qualys-cloud-agent;
in
{
  imports = [ ];

  # Interface
  options = {
    services.qualys-cloud-agent = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable the Qualys Cloud Agent service.";
      };
    };
    package = lib.mkPackageOption pkgs "qualys-cloud-agent" {
      example = "qualys-cloud-agent";
    };
    extraPackages = lib.mkOption {
      default = [ ];
      type = lib.types.listOf lib.types.package;
      example = "[ pkgs.curl ]";
      description = "Extra packages to be included in the service.";
    };
  };
  # Implementation
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [ cfg.package ];
      etc =
        {
        }; # add conf files here
    };
    systemd = {
      packages = [ cfg.package ];
      services.qualys-cloud-agent = {
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        description = "Qualys Cloud Agent";
        path = [
          cfg.package
        ] ++ cfg.extraPackages;
        #serviceConfig = {
        #  CapabilityBoundingSet = [
        #    #TODO make this based on the rpm's spec file
        #    "CAP_AUDIT_READ"
        #    "CAP_DAC_READ_SEARCH"
        #    "CAP_NET_ADMIN"
        #    "CAP_NET_RAW"
        #  ];
        #  #Type = "simple";
        #  #ExecStart = "${cfg.package}/bin/qualys-cloud-agent";
        #  #Restart = "always";
        #  #RestartSec = "5";
        #  #User = "root";
        #  #Group = "root";
        #  #Environment = "QUALYS_CLOUD_AGENT_CONFIG_FILE=/etc/qualys-cloud-agent/qualys-cloud-agent.cfg";
        #};
      };
    };
  };
}
