{ lib, pkgs, ... }:
{
  xdg.configFile."wlr-which-key/config.yaml".text = lib.generators.toYAML { } {
    font = "JetBrainsMono Nerd Font 12";
    background = "#101010";
    color = "#ffffff";
    border = "#aca1cf";
    border_width = 2;
    corner_r = 0;
    padding = 10;

    menu = [
      {
        key = "h";
        desc = "Helium";
        cmd = "${lib.getExe pkgs.helium-wayland}";
      }
      {
        key = "v";
        desc = "Vesktop";
        cmd = "${lib.getExe pkgs.vesktop-wayland}";
      }
      {
        key = "a";
        desc = "AyuGram";
        cmd = "${lib.getExe pkgs.ayugram-desktop}";
      }
      {
        key = "p";
        desc = "Pipemixer";
        cmd = "${lib.getExe pkgs.pipemixer}";
      }
      {
        key = "s";
        desc = "System";
        submenu = [
          {
            key = "r";
            desc = "Reboot";
            cmd = "systemctl reboot";
          }
          {
            key = "p";
            desc = "Poweroff";
            cmd = "systemctl poweroff";
          }
        ];
      }
    ];
  };
}
