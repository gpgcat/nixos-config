{ pkgs, config, lib, ... }:
{
  imports = [
    ./hypr
    ./librewolf
    
    ./packages.nix
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

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

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = false;
      desktop = "${config.home.homeDirectory}/desktop";
      download = "${config.home.homeDirectory}/downloads";
      documents = "${config.home.homeDirectory}/documents";
      videos = "${config.home.homeDirectory}/videos";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "video/mp4" = "mpv.desktop";
        "video/mkv" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "image/png" = "swayimg.desktop";
        "image/jpeg" = "swayimg.desktop";
        "image/gif" = "swayimg.desktop";
        "image/webp" = "swayimg.desktop";
      };
    };
  };

  wayland.windowManager.hyprland.settings.env = [
    "EDITOR,hx"
    "VISUAL,hx"
    "NIXOS_OZONE_WL,1"
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SZIE,24"
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
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -x GPG_TTY (tty)
      '';
      shellAliases = {
        nixos-switch = "sudo nixos-rebuild switch --flake ~/nix";
        home-switch = "home-manager switch --flake ~/nix";
        ls = "eza";
        ll = "eza -la";
        cat = "bat";
      };
    };
    helix = {
      enable = true;
      extraPackages = with pkgs; [
        rust-analyzer
        typescript-language-server
        nixd
        gopls
        typst
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
    gpg = {
      enable = true;
      homedir = "${config.home.homeDirectory}/.gnupg";
    };
    git = {
      enable = true;
      settings = {
        user.name = "gpgcat";
        user.email = "gpgcat@proton.me";
        init.defaultBranch = "main";
        user.signingKey = "25380268D6110BA6";
        commit.gpgSign = true;
        tag.gpgSign = true;
      };

      includes = [
        {
          condition = "gitdir:~/work/";
          path = "~/.config/git/work.include";
        }
      ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
