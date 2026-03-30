import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
  Layout.fillWidth: true
  spacing: 10

  Rectangle {
    width: 48
    height: 48
    border.width: nc.notificationCenterBorderWidth
    border.color: nc.notificationCenterBorder
    Image {
      anchors.fill: parent
      anchors.margins: 2
      sourceSize.width: 46
      sourceSize.height: 46
      source: "file://" + Quickshell.env("HOME") + "/.avatar"
    }
  }

  ColumnLayout {
    spacing: 0
    RowLayout {
      spacing: 5
      IconText {
        label: {
          let h = clock.date.getHours();
          if (h >= 5 && h < 12) return "Good morning,"
          if (h >= 12 && h < 18) return "Good afternoon,"
          if (h >= 18 && h < 22) return "Good evening,"
          return "Good night,"
        }
        font.pixelSize: 16
        font.styleName: "SemiBold"
        textColor: textColor
      }

      IconText {
        label: "Madeline"
        font.pixelSize: 16
        font.styleName: "Bold"
        Layout.fillWidth: true
        elide: Text.ElideRight
        textColor: nc.notificationSummaryForeground
      }
    }
    RowLayout {
      FontText {
        Layout.fillWidth: true
        textColor: lowContrastTextColor
        label: Qt.formatDateTime(clock.date, "hh:mm ap")
      }
      FontText {
        Layout.rightMargin: 5
        label: "uptime " + getUptime()
        textColor: lowContrastTextColor
      }
    }
  }
}

