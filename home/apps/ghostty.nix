{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      theme = "Vesper";

      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;

      window-padding-x = 10;
      window-padding-y = 10;
      window-decoration = false;

      clipboard-read = "allow";
      clipboard-write = "allow";
    };
  };
}
