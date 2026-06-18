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
	opacity = 0.9;
	blur = true;
      };
    };
  };
}
