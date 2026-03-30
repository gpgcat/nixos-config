{ pkgs, config, ... }:
{
  services.hyprpaper.enable = true;
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = config.lib.stylix.pixel "base00";

    targets = {
      gtk.enable = true;
      qt.enable = true;

      fish.enable = true;
      nvf.enable = true;

      alacritty.enable = true;
      ghostty.enable = true;
      hyprpaper.enable = true;
      hyprland.enable = true;
      spotify-player.enable = true;
      zen-browser = {
        enable = true;
        profileNames = [ "default" ];
      };
    };
  };
}
