import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "../components"

PanelWindow {
  id: popupWindow

  anchors {
    top: true
    right: true
  }
  
  margins {
    top: 10
    right: 10
  }

  color: "transparent"
  implicitWidth: 400
  implicitHeight: layout.implicitHeight
  
  visible: notifList.count > 0

  property color notificationBackground: colors.background
  property color notificationBorder: colors.foreground
  property int notificationBorderWidth: 2

  property color notificationSummaryForeground: colors.foreground
  property color notificationBodyForeground: colors.text

  ColumnLayout {
    id: layout
    width: parent.width
    spacing: 5

    Repeater {
      id: notifList
      model: notifServer.trackedNotifications
      
      delegate: Rectangle {
        Layout.fillWidth: true
        implicitHeight: 80
        color: notificationBackground
        border.width: notificationBorderWidth
        border.color: notificationBorder

        Timer {
          interval: 5000
          running: true
          onTriggered: modelData.dismiss()
        }

        MouseArea {
          anchors.fill: parent
          onClicked: modelData.dismiss()
        }

        RowLayout {
          anchors.fill: parent
          anchors.margins: 10
          spacing: 10

          Image {
            source: {
              let i = modelData.icon || modelData.appIcon || ""
              if (i.startsWith("/")) return "file://" + i
              if (i.length > 0) return "image://desktop-icon/" + i
              return ""
            }
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            fillMode: Image.PreserveAspectFit
            visible: source.toString() !== ""
          }

          ColumnLayout {
            Layout.fillWidth: true
            
            FontText {
              label: modelData.summary
              textColor: notificationSummaryForeground
              font.bold: true
              elide: Text.ElideRight
              Layout.fillWidth: true
            }

            FontText {
              label: modelData.body
              textColor: notificationBodyForeground
              elide: Text.ElideRight
              maximumLineCount: 2
              wrapMode: Text.WordWrap
              Layout.fillWidth: true
            }
          }
        }
      }
    }
  }
}

