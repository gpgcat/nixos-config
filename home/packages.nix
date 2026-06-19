{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ayugram-desktop
    vesktop-wayland
    helium-wayland
    waybar
    wlr-which-key
    obs-studio

    yazi
    xwayland-satellite
    gpu-screen-recorder
    wf-recorder
    awww
    fzf
    pipemixer
    wl-clipboard
    libnotify

    nerd-fonts.jetbrains-mono
  ];
}
