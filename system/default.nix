{ config, lib, pkgs, inputs, ... }:

{
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];

      experimental-features = [
        "nix-command"
        "flakes"
        "impure-derivations"
        "ca-derivations"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  networking.networkmanager.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
  };
  
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "grp:ctrl_space_toggle,caps:escape";

  users.users.madeline = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "dialout"
    ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    helix
    neovim
    wget
    curl
    gcc
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    noto-fonts
    adwaita-fonts
  ];

  hardware.graphics.enable = true;

  services = {
    openssh.enable = true;
    dbus.enable = true;
    fwupd.enable = true;
    mullvad-vpn.enable = true;
    flatpak.enable = true;
    udev = {
      enable = true;
      packages = [
        pkgs.qmk-udev-rules
      ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  security = {
    polkit.enable = true;
    sudo.enable = true;
    rtkit.enable = true;
  };

  programs = {
    git.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    steam.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.etc.hosts.mode = "0644";

  system.stateVersion = "26.05";
}
