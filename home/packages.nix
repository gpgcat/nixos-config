{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ayugram-desktop
    vesktop-wayland
    helium-wayland
    waybar
    wlr-which-key

    yazi
    awww
    fzf
    pipemixer
    wl-clipboard
    libnotify

    nerd-fonts.jetbrains-mono
  ];
}
