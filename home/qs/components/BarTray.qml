import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls

Row {
  spacing: 5

  Repeater {
    model: SystemTray.items
    delegate: Item {
      id: trayItem
      width: 16
      height: 16

      Image {
        anchors.fill: parent
        source: modelData.icon ?? ""
        sourceSize.width: width
        sourceSize.height: height
      }

      QsMenuOpener {
        id: menuOpener
        menu: modelData.menu
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
          if (mouse.button === Qt.RightButton) {
            var pos = trayItem.mapToItem(null, 0, 0)
            modelData.display(bar, pos.x, bar.panelHeight + bar.marginTop)
          } else {
            modelData.activate()
          }
        }
      }
    }
  }
}
