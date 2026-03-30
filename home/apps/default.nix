{ config, pkgs, ... }:
{
  imports = [
    ./zen.nix
  ];
  home.packages = with pkgs; [
    # cli
    gdu
    tree
    onefetch
    cava
    fastfetch
    ffmpeg
    imagemagick

    # gui
    krita
    quickshell
    ayugram-desktop
    obs-studio
    zathura
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
  };
}
