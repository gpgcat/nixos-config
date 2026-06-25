{
  pkgs,
  hostname,
  lib,
  ...
}:
{
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        enableEditor = true;
        maxGenerations = 10;

        style = {
          wallpapers = lib.mkForce [ ];
          interface = {
            branding = "nixos uwu";
            brandingColor = "aca1cf";
            helpHidden = true;
          };
          graphicalTerminal = {
            font.scale = "1x1";

            background = "000000";
            foreground = "ffffff";

            brightBackground = "000000";
            brightForeground = "ffffff";

            palette = "000000;f5a191;90b99f;e6b99d;aca1cf;e29eca;ea83a5;a0a0a0";
            brightPalette = "7e7e7e;ff8080;99ffe4;ffc799;b9aeda;ecaad6;f591b2;ffffff";
          };
        };
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
