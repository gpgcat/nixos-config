{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine = {
    enable = true;
    enableEditor = true;
    maxGenerations = 10;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
