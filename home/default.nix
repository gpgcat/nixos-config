{ pkgs, config, lib, inputs, ... }:
{
  imports = [
    ./hypr
    ./librewolf
  ];

  programs.home-manager.enable = true;

  home = {
    username = "madeline";
    homeDirectory = "/home/madeline";
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      size = 48;
      package = pkgs.bibata-cursors;
    };
  };

  wayland.windowManager.hyprland.settings.env = [
    "EDITOR,hx"
    "VISUAL,hx"
    "NIXOS_OZONE_WL,1"
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SZIE,24"
  ];

  home.packages = with pkgs; [
    ayugram-desktop
    gnupg
  ];

  home.stateVersion = "26.05";

  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
    };
  };

  programs = {
    yazi.enable = true;
    helix = {
      enable = true;
      extraPackages = with pkgs; [
        rust-analyzer
        typescript-language-server
        nixd
        gopls
        basedpyright
      ];
      settings = {
        theme = "merionette";
        editor = {
          line-number = "relative";
          cursor-shape.insert = "bar";
        };
      };
    };
    kitty = lib.mkForce {
      enable = true;
      themeFile = "Ayaka";
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        window_padding_width = 10;
        font_family = "Iosevka Nerd Font";
        font_size = 14;
      };
    };
    git = {
      enable = true;
      settings = {
        user.name = "gpgcat";
        user.email = "gpgcat@proton.me";
        init.defaultBranch = "main";
      };

      includes = [
        {
          condition = "gitdir:~/work/";
          path = "~/.config/git/work.include";
        }
      ];
    };
  };
}
