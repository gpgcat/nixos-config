{ pkgs, config, ... }:
{
  services.hyprpaper.enable = true;
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      serif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Serif";
      };
      sansSerif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans";
      };
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      emoji = {
        package = pkgs.twemoji-color-font;
        name = "Twitter Color Emoji";
      };
    };

    image = config.lib.stylix.pixel "base00";

    targets = {
      gtk.enable = true;
      qt.enable = true;

      fish.enable = true;
      nvf.enable = true;

      alacritty.enable = true;
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
