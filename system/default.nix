{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  
    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  networking = {
    networkmanager.enable = true;
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    steam-hardware.enable = true;

    enableRedistributableFirmware = true;
  };

  users.users.angel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "networkmanager"
      "dialout"
    ];
  };

  services = {
    openssh.enable = true;

    dbus = {
      enable = true;
    };

    fwupd.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    #flatpak.enable = true;
  };

  systemd.coredump.extraConfig = ''
    ProcessSizeMax=2G
    ExternalSizeMax=2G
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernel.sysctl."kernel.sysrq" = 1;

  environment.systemPackages =
    with pkgs;
    [
      man-pages
      htop
      wget
      tmux
      inetutils
      dig
      pciutils
      usbutils
      git
      neovim
      gnupg
      pinentry-curses
    ]
    ++ (with hunspellDicts; [
      en_US
      ru_RU
    ]);

  fonts.packages =
    with pkgs;
    [
      cozette
      nerd-fonts.jetbrains-mono
      adwaita-fonts
    ];

  security = {
     polkit.enable = true;
     sudo.enable = true;
     rtkit.enable = true;
  };

  programs = {
    dconf.enable = true;
    hyprland.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };

  environment.etc.hosts.mode = "0644";
  nixpkgs.config.allowUnfree = true;
  boot.plymouth.enable = true;

  system.stateVersion = "26.05";
}
