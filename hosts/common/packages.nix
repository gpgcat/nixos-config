{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    limine-full
    neovim
    wget
    tree
    git
    home-manager
  ];

  programs = {
    niri.enable = true;
    fish.enable = true;
  };
}
