{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  #env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [pkgs.git];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  #Scripts.hello.exec = ''
  #  echo hello from $GREET
  #'';

  enterShell = ''
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  #enterTest = ''
  #  echo "Running tests"
  #  git --version | grep --color=auto "${pkgs.git.version}"
  #'';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;
  git-hooks.hooks = {
    shellcheck.enable = true;
    alejandra = {
      enable = true;
      settings.exclude = [
        "./.devenv.flake.nix"
      ];
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
