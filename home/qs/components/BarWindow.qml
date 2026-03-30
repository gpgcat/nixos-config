import Quickshell.Wayland
import QtQuick

FontText {
  textColor: textColor
  label: ToplevelManager.activeToplevel ? ToplevelManager.activeToplevel.title : "desktop"
  width: 600
  elide: Text.ElideRight
  horizontalAlignment: Text.AlignHCenter
}
