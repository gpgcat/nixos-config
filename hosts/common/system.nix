{ pkgs, hostname, ... }:
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

  networking = {
    networkmanager.enable = true;
    networking.hostName = hostname;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Inter" ];
    };
    localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <match target="pattern">
          <test name="family" qual="any">
            <string>DejaVu Sans</string>
          </test>
          <edit name="family" mode="assign" binding="same">
            <string>Inter</string>
          </edit>
        </match>
      </fontconfig>
    '';
  };

  system.stateVersion = "26.05";
}
