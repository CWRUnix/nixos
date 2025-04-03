{ pkgs, ... }:
{
  systemd = {
    #timers.cringe-dns = {
    #  wantedBy = [ "timers.target" ];
    #  timerConfig = {
    #    OnBootSec = "5m";
    #    OnUnitActiveSec = "5m";
    #    Unit = "cringe-dns.service";
    #  };
    #};
    #services.cringe-dns = {
    #  script = ''
    #    set -eu
    #    ${pkgs.nettools}/bin/ifconfig | ${pkgs.netcat-gnu}/bin/netcat -cvt murray-hill.asuscomm.com 12345 --wait=5
    #  '';
    #  serviceConfig = {
    #    User = "root";
    #    Type = "oneshot";
    #  };
    #};
    services.discord-bot = {
      description = "Discord bot client for the Linux Club Discord";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [
        pkgs.nettools # provides ifconfig
      ];
      serviceConfig = {
        User = "root"; # needs root to read /run/secrets/discord-bot.env
        Restart = "always";
        RestartSec = "5s";
        EnvironmentFile = "/run/secrets/discord-bot.env"; # this file is read protected on the server. chmod 700 :)
        ExecStart =
          let
            # Heres what everything does in C-family style function syntax:
            #   pkgs.writers.writePython3 ( script_name: string, attributes: attrs, script: string ) -> package
            #     https://github.com/NixOS/nixpkgs/blob/09aec857dfc9c2005985c902861777e6f110ad2a/pkgs/build-support/writers/scripts.nix#L1257
            #   builtins.readFile ( path: file_path) -> string
            #     https://nix.dev/manual/nix/2.23/language/builtins#builtins-readFile
            discordBotPythonScript = pkgs.writers.writePython3Bin "bot" {
              libraries = with pkgs.python312Packages; [
                discordpy
              ];
            } (builtins.readFile ./bot.py);
          in
          "${discordBotPythonScript}/bin/bot";
      };
    };
  };
}
