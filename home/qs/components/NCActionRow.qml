import Quickshell.Io
import QtQuick
import QtQuick.Layouts

RowLayout {
  Layout.fillWidth: true
  spacing: 5


  // process stuff
  Process { id: shutdownProc; command: ["qs", "ipc", "call", "nc", "close"]; running: false }
  Process { id: rebootProc; command: ["qs", "ipc", "call", "nc", "close"]; running: false }
  Process { id: sleepProc; command: ["qs", "ipc", "call", "nc", "close"]; running: false }

  Rectangle {
    Layout.fillWidth: true
    height: 50
    color: nc.notificationCenterActionBackground
    border.width: nc.notificationCenterBorderWidth
    border.color: nc.notificationCenterBorder

    IconText {
      anchors.centerIn: parent
      label: "󰐥"
      font.pixelSize: 26
      textColor: nc.notificationCenterActionForeground
    }

    MouseArea {
      anchors.fill: parent
      onClicked: shutdownProc.running = true
    }
  }

  Rectangle {
    Layout.fillWidth: true
    height: 50
    color: nc.notificationCenterActionBackground
    border.width: nc.notificationCenterBorderWidth
    border.color: nc.notificationCenterBorder

    IconText {
      anchors.centerIn: parent
      label: ""
      font.pixelSize: 26
      textColor: nc.notificationCenterActionForeground
    }

    MouseArea {
      anchors.fill: parent
      onClicked: rebootProc.running = true
    }
  }

  Rectangle {
    Layout.fillWidth: true
    height: 50
    color: nc.notificationCenterActionBackground
    border.width: nc.notificationCenterBorderWidth
    border.color: nc.notificationCenterBorder

    IconText {
      anchors.centerIn: parent
      label: "󰤄"
      font.pixelSize: 26
      textColor: nc.notificationCenterActionForeground
    }

    MouseArea {
      anchors.fill: parent
      onClicked: sleepProc.running = true
    }
  }
}
