{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    devenv
    direnv
  ];
}
