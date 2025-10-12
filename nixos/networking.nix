{
  config,
  pkgs,
  host-name,
  ...
}:
{
  networking.hostName = host-name;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80 # Nginx
      443 # Nginx
      8000
      4430
    ];
  };
  networking.timeServers = [
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
    "time.google.com"
    "time2.google.com"
    "time3.google.com"
    "time4.google.com"
  ];
}
