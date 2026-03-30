import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "../components"

PanelWindow {
  id: bar
  anchors {
    top: true
    left: true
    right: true
  }

  property int marginTop: 5
  property int marginLeft: 5
  property int marginRight: 5
  property int marginBottom: 5

  property int paddingLeft: 5
  property int paddingRight: 5

  property var colors: root.colors

  property int panelHeight: 30
  property color panelBackground: colors.background
  property color panelBorderColor: colors.foreground
  property int panelBorderWidth: 2

  property color workspacesActiveBackground: colors.foreground
  property color workspacesActiveForeground: colors.background
  property color workspacesBackground: colors.background
  property color workspacesForeground: colors.foreground

  property color volumeSliderBackground: colors.slider
  property color volumeSliderHandle: colors.foreground

  property color textColor: colors.text

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  readonly property var player: Mpris.players.length > 0 ? Mpris.players[0] : null

  margins {
    top: marginTop
    left: marginLeft
    right: marginRight
  }

  implicitHeight: panelHeight
  color: "transparent"

  Process { id: ncProc; command: ["qs", "ipc", "call", "nc", "toggle"]; running: false }

  // bg
  Rectangle {
    width: parent.width
    height: parent.height
    color: panelBackground
    border.color: panelBorderColor
    border.width: panelBorderWidth
  }

  // left row
  Row {
    anchors {
      left: parent.left
      leftMargin: panelBorderWidth + paddingLeft
      verticalCenter: parent.verticalCenter
    }
    spacing: 10

    BarWorkspaces {}
    BarMpris {}
  }

  // center row
  Row {
    anchors.centerIn: parent

    BarWindow {}
  }
  
  // right row
  RowLayout {
    anchors {
      right: parent.right
      rightMargin: panelBorderWidth + paddingRight
      verticalCenter: parent.verticalCenter
    }
    spacing: 5
  
    BarTray { Layout.alignment: Qt.AlignVCenter }
    BarVolume { Layout.alignment: Qt.AlignVCenter }
    BarClock { Layout.alignment: Qt.AlignVCenter }

    MouseArea {
      Layout.alignment: Qt.AlignVCenter
      width: 16
      height: 16
      cursorShape: Qt.PointingHandCursor
      onClicked: ncProc.running = true
    
      IconText {
        anchors.centerIn: parent
        label: "󰂚"
        textColor: bar.textColor
      }
    }
  }
}
