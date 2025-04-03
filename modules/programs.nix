{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    unstable.devenv
  ];
  programs = {
    tmux.enable = true;
    nix-ld.enable = true;
    direnv = {
      enable = true;
      package = pkgs.unstable.direnv;
      nix-direnv = {
        enable = true;
        package = pkgs.unstable.nix-direnv;
      };
    };

    # shells
    fish.enable = true;
    zsh.enable = true;
  };
}
