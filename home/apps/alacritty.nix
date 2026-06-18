{ ... }:
{
  programs.alacritty = {
    enable = true;
    theme = "vesper";
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "None";
      };
      font.normal.family = "JetBrainsMono Nerd Font";
      font.size = 14;
    };
  };
}
