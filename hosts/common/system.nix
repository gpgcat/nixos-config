{ pkgs, hostname, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        enableEditor = true;
        maxGenerations = 10;
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
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

  hardware.graphics.enable = true;

  system.stateVersion = "26.05";
}
