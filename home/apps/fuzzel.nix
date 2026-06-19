{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        use-bold = true;
        placeholder = "search...";
        terminal = "alacritty -e {cmd}";
      };
      border = {
        width = 2;
        radius = 0;
      };
      colors =
        let
          fg = "ffffffff";
          bg = "101010ff";
          muted = "7e7e7eff";
          accent = "aca1cfff";
        in
        {
          background = bg;
          text = fg;
          message = fg;
          prompt = fg;
          placeholder = muted;
          input = fg;
          match = accent;
          selection = accent;
          selection-text = bg;
          selection-match = fg;
          counter = accent;
          border = accent;
        };
    };
  };
}
