{ pkgs, ... }:
{
  systemd = {
    timers.cringe-dns = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "cringe-dns.service";
      };
    };
    services.cringe-dns = {
      script = ''
        set -eu
        ${pkgs.nettools}/bin/ifconfig | ${pkgs.netcat-gnu}/bin/netcat murray-hill.asuscomm.com 12345 -c
      '';
      serviceConfig = {
        User = "root";
        Type = "oneshot";
      };
    };
  };
}
