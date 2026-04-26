{ lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
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
    upower.enable = true;
    "06cb-009a-fingerprint-sensor" = {
      enable = true;
      backend = "python-validity";
    };
  };

  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
  };
}
