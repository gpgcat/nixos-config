{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # communication
    ayugram-desktop
    telegram-desktop
    vesktop
    signal-desktop

    # gui apps
    spotify
    mpv
    swayimg
    zathura
    prismlauncher

    # cli tools
    ffmpeg
    htop
    btop
    bat
    eza
    psmisc
    ripgrep
    bubblewrap
    rbw
    file
    fzf
    jq
    yq
    tokei
    ncdu
    p7zip
    unzip
    zip
    socat
    tcpdump
    nmap
    slurp
    wf-recorder
    wl-clipboard

    # rust stuff (rust-analyzer installed in helix extraPackages)
    rustc
    cargo
    rustfmt
    clippy
  ];
}
