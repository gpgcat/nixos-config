{ lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./disko.nix
    ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = lib.mkForce false;
    initrd.systemd.enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  hardware = {
    bluetooth.enable = true;
    alsa.enablePersistence = true;
  };
}
