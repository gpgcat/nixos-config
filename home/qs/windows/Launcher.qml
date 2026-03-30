import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland
import "../components"

FloatingWindow {
  id: launcher
  implicitWidth: 300
  implicitHeight: 400
  visible: false
  title: "App Launcher"

  property var colors: root.colors
  property var selectedApp: null
  property var allApps: []
  property var filteredApps: []

  color: "transparent"

  function updateFilter(text) {
    filteredApps = text === ""
      ? allApps.slice()
      : allApps.filter(app => app.name.toLowerCase().includes(text.toLowerCase()))
  }

  Rectangle {
    anchors.fill: parent
    color: colors.background
    border.color: colors.foreground
    border.width: 2
  }

  HyprlandFocusGrab {
    active: launcher.visible
    windows: [launcher]
    onCleared: launcher.visible = false
  }

  ListView {
    width: 1; height: 1
    opacity: 0
    model: DesktopEntries.applications
    delegate: Item {
      width: 1; height: 1
      Component.onCompleted: {
	if (!launcher.allApps.find(a => a === modelData)) {
          launcher.allApps = [...launcher.allApps, modelData]
          launcher.updateFilter(searchInput.text)
        }
      }
    }
  }

  Connections {
    target: DesktopEntries.applications
    function onObjectInsertedPost(obj) {
      launcher.allApps = [...launcher.allApps, obj]
      launcher.updateFilter(searchInput.text)
    }
    function onObjectRemovedPost(obj) {
      launcher.allApps = launcher.allApps.filter(a => a !== obj)
      launcher.updateFilter(searchInput.text)
    }
  }

  Column {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    TextField {
      id: searchInput
      width: parent.width
      height: 40
      placeholderText: "search apps..."
      font.family: "Cozette"
      focus: true
      font.styleName: "HiDpi"
      color: colors.text

      background: Rectangle {
        color: "transparent"
        border.color: colors.foreground
        border.width: 1
      }

      onVisibleChanged: if (visible) { text = ""; forceActiveFocus() }
      onTextChanged: {
        launcher.updateFilter(text)
	appList.currentIndex = filteredApps.length > 0 ? 0 : -1	
      }

      Keys.onPressed: event => {
        if (!launcher.visible) return
        switch (event.key) {
          case Qt.Key_Up:
            if (appList.currentIndex > 0) appList.currentIndex--
            event.accepted = true
            break
          case Qt.Key_Down:
            if (appList.currentIndex < appList.count - 1) appList.currentIndex++
            event.accepted = true
            break
          case Qt.Key_Return:
          case Qt.Key_Enter:
            if (appList.currentIndex >= 0) {
              launcher.selectedApp.execute()
              launcher.visible = false
            }
            event.accepted = true
            break
          case Qt.Key_Escape:
            launcher.visible = false
            event.accepted = true
            break
        }
      }
    }

    ListView {
      id: appList
      width: parent.width
      height: parent.height - searchInput.height - 20
      model: launcher.filteredApps
      spacing: 2
      clip: true
      currentIndex: -1
      highlightMoveDuration: 150
      highlightFollowsCurrentItem: true

      highlight: Rectangle {
        color: colors.foreground
        opacity: 0.3
        radius: 2
      }

      onCountChanged: currentIndex = Math.min(currentIndex, count - 1)

      onCurrentIndexChanged: {
        launcher.selectedApp = (currentIndex >= 0 && currentItem)
          ? currentItem.appData
          : null
      }

      delegate: Rectangle {
        property var appData: modelData
        width: ListView.view.width
        height: 40
        color: "transparent"
        border.color: colors.foreground
        border.width: 1

        Row {
          anchors.verticalCenter: parent.verticalCenter
          spacing: 10
          leftPadding: 5

          Image {
            width: 32; height: 32
            source: Quickshell.iconPath(modelData.icon)
          }

          FontText {
            label: modelData.name
            textColor: colors.text
            anchors.verticalCenter: parent.verticalCenter
          }
        }

        MouseArea {
          anchors.fill: parent
          onPressed: launcher.selectedApp = modelData
          onClicked: { modelData.execute(); launcher.visible = false }
        }
      }
    }
  }

  IpcHandler {
    target: "launcher"
    function toggle() {
      if (!launcher.visible) {
        searchInput.text = ""
      }
      launcher.visible = !launcher.visible
    }
  }
}
