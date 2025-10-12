{ config, lib }:
{
  options = {
    consts.drives = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            persisted-directories = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              description = ''
                Persisted stuff goes under config.consts.<name>.persisted-directories = [ ...list of directories ];
              '';
            };
          };
        }
      );
      default = { };
      description = ''
        Drive-specific configuration options.
      '';
    };
  };

  config = {
    environment.persistence.location = lib.concatMapAttrs (name: val: [
      {
        "${val.mountpoint}/persist" = {
          hideMounts = false;
          directories = val.persisted-directories;
        };
      }
    ]) config.consts.drives;
  };
}
