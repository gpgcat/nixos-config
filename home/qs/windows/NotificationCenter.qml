import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "../components"

PanelWindow {
  id: nc

  exclusiveZone: 0
  focusable: true

  anchors {
    right: true
    top: true
    bottom: true
  }

  property int marginTop: 5
  property int marginLeft: 5
  property int marginRight: 5
  property int marginBottom: 5

  margins {
    top: marginTop
    bottom: marginBottom
    right: marginRight
  }

  implicitWidth: 400

  visible: false

  property var colors: root.colors

  property color notificationCenterBackground: colors.background
  property color notificationCenterBorder: colors.foreground
  property int notificationCenterBorderWidth: 2

  property color notificationCenterActionBackground: colors.background
  property color notificationCenterActionForeground: colors.foreground

  property color notificationBackground: colors.background
  property color notificationSummaryForeground: colors.foreground
  property color notificationBodyForeground: colors.text

  property color textColor: colors.text
  property color lowContrastTextColor: colors.slider

  property color volumeSliderBackground: colors.slider
  property color volumeSliderHandle: colors.foreground

  color: "transparent"

  // bg
  Rectangle {
    width: parent.width
    height: parent.height
    color: notificationCenterBackground
    border.color: notificationCenterBorder
    border.width: notificationCenterBorderWidth
  }

  // visibility and ipc stuff
  IpcHandler {
    target: "nc"
    function close() {
      nc.visible = false
    }
    function toggle() {
      nc.visible = !nc.visible
    }
  }

  HyprlandFocusGrab {
    active: nc.visible
    windows: [nc]
    onCleared: {
      nc.visible = false
    }
  }
  

  // other stuff
  function getUptime() {
    let diffMs = clock.date - root.startTime
    let diffMins = Math.floor(diffMs / 60000)
    if (diffMins < 60) return diffMins + "m";
    return Math.floor(diffMins / 60) + "h " + (diffMins % 60) + "m"
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 5
    spacing: 5

    NCGreeting {}
    NCActionRow {}
    NCVolume {}
    NCNotificationPlaceholder {}

    ListView {
      id: notifList
      visible: count > 0
      Layout.fillHeight: true
      Layout.fillWidth: true
      model: notifServer.trackedNotifications
      spacing: 5

      delegate: Rectangle {
	width: notifList.width
        height: 80
        color: notificationBackground
        border.width: notificationCenterBorderWidth
        border.color: notificationCenterBorder

        MouseArea {
	  anchors.fill: parent
          onClicked: modelData.dismiss()
        }

	RowLayout {
	  anchors.fill: parent
	  anchors.margins: 10
	  spacing: 5

	  Image {
	    source: {
	      let i = modelData.icon || modelData.appIcon || ""
	      if (i.startsWith("/")) return "file://" + i
	      if (i.length > 0) return "image://desktop-icon/" + i
	      return ""
	    }
	    fillMode: Image.PreserveAspectFit
	    visible: source.toString() !== ""
	    Layout.preferredWidth: 32
	    Layout.preferredHeight: 32
	  }

          ColumnLayout {
	    Layout.fillWidth: true
  
            FontText {
              label: modelData.summary
              textColor: notificationSummaryForeground
	      elide: Text.ElideRight
            }
  
            FontText {
              label: modelData.body
              textColor: notificationBodyForeground
              wrapMode: Text.WordWrap
	      elide: Text.ElideRight
	      maximumLineCount: 2
              Layout.fillWidth: true
            }
	  }
 	}
      }
    }
  }
}
