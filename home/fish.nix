{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
    ];
  };
}
