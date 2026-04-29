{ ... }:
let
  autostart = [
    "caelestia shell &"
  ];
  general = {
    gaps_in = 5;
    gaps_out = 5;
    border_size = 2;
    "col.active_border" = "rgba(cedaebee)";
    "col.inactive_border" = "rgba(36283daa)";
    resize_on_border = false;
    allow_tearing = false;
    layout = "dwindle";
  };
  decoration = {
    rounding = 20;
    rounding_power = 2;
    active_opacity = 1.0;
    inactive_opacity = 1.0;

    shadow = {
      enabled = true;
      range = 4;
      render_power = 3;
      color = "rgba(000000ee)";
    };

    blur = {
      enabled = true;
      size = 3;
      passes = 1;

      vibrancy = 0.1696;
    };
  };
  animations = {
    enabled = "yes, please :)";

    bezier = [
      "easeOutQuint, 0.23, 1, 0.32, 1"
      "easeInOutCubic, 0.65, 0.05, 0.36, 1"
      "linear, 0, 0, 1, 1"
      "almostLinear, 0.5, 0.5, 0.75, 1"
      "quick, 0.15, 0, 0.1, 1"
    ];

    animation = [
      "global, 1, 10, default"
      "border, 1, 5.39, easeOutQuint"
      "windows, 1, 4.79, easeOutQuint"
      "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
      "windowsOut, 1, 1.49, linear, popin 87%"
      "fadeIn, 1, 1.73, almostLinear"
      "fadeOut, 1, 1.46, almostLinear"
      "fade, 1, 3.03, quick"
      "layers, 1, 3.81, easeOutQuint"
      "layersIn, 1, 4, easeOutQuint, fade"
      "layersOut, 1, 1.5, linear, fade"
      "fadeLayersIn, 1, 1.79, almostLinear"
      "fadeLayersOut, 1, 1.39, almostLinear"
      "workspaces, 1, 1.94, almostLinear, fade"
      "workspacesIn, 1, 1.21, almostLinear, fade"
      "workspacesOut, 1, 1.94, almostLinear, fade"
      "zoomFactor, 1, 7, quick"
    ];
  };
  input = {
    kb_layout = "us,ru";
    kb_options = "grp:ctrl_space_toggle,caps:escape";
  };
  gestures = [
    "3, horizontal, workspace"
    "3, down, mod: ALT, close"
    "3, up, mod: SUPER, scale: 1.5, fullscreen"
  ];
  mod = "SUPER";
  binds = [
    "$mod, Q, exec, uwsm app -- kitty"
    "$mod, C, killactive,"
    "$mod, M, exec, command -v hyprshutdown > /dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
    "$mod, E, exec, kitty -e yazi"
    "$mod, V, togglefloating,"
    "$mod, F, fullscreen,"
    "$mod, R, exec, caelestia shell drawers toggle launcher"
    "$mod, N, exec, caelestia shell drawers toggle sidebar"
    "$mod, P, pseudo,"
    "$mod, J, layoutmsg, togglesplit"
    "$mod, L, exec, caelestia shell lock lock"

    ", Print, exec, caelestia screenshot -r -f"

    "$mod, left, movefocus, l"
    "$mod, right, movefocus, r"
    "$mod, up, movefocus, u"
    "$mod, down, movefocus, d"

    "$mod, 1, workspace, 1"
    "$mod, 2, workspace, 2"
    "$mod, 3, workspace, 3"
    "$mod, 4, workspace, 4"
    "$mod, 5, workspace, 5"
    "$mod, 6, workspace, 6"
    "$mod, 7, workspace, 7"
    "$mod, 8, workspace, 8"
    "$mod, 9, workspace, 9"
    "$mod, 0, workspace, 10"

    "$mod SHIFT, 1, movetoworkspace, 1"
    "$mod SHIFT, 2, movetoworkspace, 2"
    "$mod SHIFT, 3, movetoworkspace, 3"
    "$mod SHIFT, 4, movetoworkspace, 4"
    "$mod SHIFT, 5, movetoworkspace, 5"
    "$mod SHIFT, 6, movetoworkspace, 6"
    "$mod SHIFT, 7, movetoworkspace, 7"
    "$mod SHIFT, 8, movetoworkspace, 8"
    "$mod SHIFT, 9, movetoworkspace, 9"
    "$mod SHIFT, 0, movetoworkspace, 10"

    "$mod, mouse_down, workspace, e+1"
    "$mod, mouse_up, workspace, e-1"
  ];
  bindms = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];
  bindels = [
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
    ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"

    "$mod SHIFT, L, exec, caelestia shell -d"
    "$mod SHIFT, L, exec, caelestia shell lock lock"
  ];
  windowrules = [
    {
      name = "supress-maximize-events";
      "match:class" = ".*";

      suppress_event = "maximize";
    }
    {
      name = "fix-xwayland-drags";
      "match:class" = "^$";
      "match:title" = "^$";
      "match:xwayland" = true;
      "match:float" = true;
      "match:fullscreen" = false;
      "match:pin" = false;

      no_focus = true;
    }
  ];
in
{
  imports = [
    ./caelestia.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = autostart;
      general = general;
      decoration = decoration;
      animations = animations;
      dwindle = { preserve_split = true; };
      master = { new_status = "master"; };
      misc = { allow_session_lock_restore = true; };
      input = input;
      gesture = gestures;
      "$mod" = mod;
      bind = binds;
      bindm = bindms;
      bindel = bindels;
      windowrule = windowrules;
    };
  };
}
