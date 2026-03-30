{ pkgs, config, lib, ... }:
{
  programs.home-manager.enable = true;
  # test2

  imports = [
    ./hypr
    ./apps
    ./nvf

    ./env.nix
    ./stylix.nix
  ];

  home = {
    username = "angel";
    homeDirectory = "/home/angel";
    pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
  };

  home.packages = with pkgs; [
    libqalculate
    jq
    ripgrep
    pdfgrep
    file
    xdg-utils
    wl-clipboard
    libnotify

    clang
    gnumake
    cargo
    rustc
    (python3.withPackages (
      ps: with ps; [
        ipython
      ]
    ))
    gdb
    strace

    nmap
    netcat-gnu
  ];

  systemd.user = {
    startServices = "suggest";
  };

  programs.fzf.enable = true;
  programs.fish.enable = true;

  programs.fish.shellInit = ''
    set -x GPG_TTY (tty)
  '';

  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = "fish";
      font = lib.mkForce {
	size = 12;
        normal = {
          family = "Unifont";
        };
      };
      window.padding = lib.mkForce {
        x = 5;
	y = 5;
      };
    };
  };

  services.ssh-agent.enable = true;

  programs.git = {
    enable = true;
    signing = {
      key = "25380268D6110BA6";
      signByDefault = true;
      format = "openpgp";
    };
    settings = {
      user = {
        name = "gpgcat";
	email = "gpgcat@proton.me";
      };

      rebase.autosquash = true;

      init.defaultBranch = "main";

      core.pager = "less -+X";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  xdg.configFile.quickshell = {
    source = ./qs;
    recursive = true;
  };

  xdg.configFile."quickshell/Colors.qml".text = ''
  import QtQuick

  QtObject {
    property color background: "#${config.lib.stylix.colors.base00}"
    property color foreground: "#${config.lib.stylix.colors.base0D}"
    property color slider: "#${config.lib.stylix.colors.base03}"
    property color text: "#${config.lib.stylix.colors.base05}"
  }
  '';

  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.quickshell}/bin/quickshell";
      Restart = "on-failure";
      RestartSec = 3;
      Environment = [
        "QML_DISABLE_DISK_CACHE=1"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.activation.restartQuickshell = lib.hm.dag.entryAfter ["reloadSystemd"] ''
    ${pkgs.systemd}/bin/systemctl --user restart quickshell.service || true
  '';

  home.stateVersion = "26.05";
}
