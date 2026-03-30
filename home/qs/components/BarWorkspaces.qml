import QtQuick
import Quickshell.Hyprland

Row {
  Repeater {
    model: Hyprland.workspaces
    
    delegate: Rectangle {
      width: 20
      height: 20
      color: modelData.active ? bar.workspacesActiveBackground : bar.workspacesBackground
    
      FontText {
        anchors.centerIn: parent
        label: modelData.name
        textColor: modelData.active ? bar.workspacesActiveForeground : bar.workspacesForeground
      }
    
      MouseArea {
        anchors.fill: parent
        onClicked: modelData.activate()
      }
    }
  }
}
