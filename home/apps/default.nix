{ config, pkgs, ... }:
{
  imports = [
    ./zen.nix
  ];
  home.packages = with pkgs; [
    # cli
    gdu
    opencode
    tree
    onefetch
    cava
    fastfetch
    ffmpeg
    imagemagick

    # gui
    krita
    remmina
    quickshell
    ayugram-desktop
    obs-studio
    mpv
    swayimg
    hyprshot
    cinny-desktop
  ];

  programs = {
    ghostty.enable = true;
    yazi.enable = true;
    alacritty.enable = true;
    vesktop.enable = true;
    spotify-player.enable = true;
    zathura.enable = true;
  };

  programs.zathura.options = {
    recolor = true;
    recolor-darkcolor = "#dcdccc";
    recolor-lightcolor = "#1f1f1f";
  };
}
