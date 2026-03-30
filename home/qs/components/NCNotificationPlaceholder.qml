import QtQuick
import QtQuick.Layouts

Item {
  Layout.fillWidth: true
  Layout.fillHeight: true
  visible: notifList.count === 0

  FontText {
    label: "(no notifications)"
    textColor: nc.lowContrastTextColor
    anchors.centerIn: parent
  }
}
