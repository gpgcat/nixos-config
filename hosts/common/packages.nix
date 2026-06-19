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

  fonts.packages = with pkgs; [
    inter
  ];

  programs = {
    niri.enable = true;
    fish.enable = true;
  };
}
