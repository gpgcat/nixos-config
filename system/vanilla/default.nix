{ lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./disko.nix
    ];

  services.xserver.videoDrivers = [ "modesetting" ];

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

  services = {
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
