//@ pragma UseQApplication
import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import "windows"

ShellRoot {
  id: root

  readonly property var colors: {
    const comp = Qt.createComponent("file://" + Quickshell.env("HOME") + "/.config/quickshell/Colors.qml")
    if (comp.status === Component.Ready) return comp.createObject(root)
    console.error("error loading colors:", comp.errorString())
    return null
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  readonly property var startTime: new Date()
  
  NotificationServer {
    id: notifServer
    actionsSupported: true
    bodySupported: true
    bodyMarkupSupported: true
    imageSupported: true
    keepOnReload: true

    onNotification: (notification) => {
      notification.tracked = true
    }
  }

  Bar {}
  NotificationCenter {}
  NotificationPopups {}
  Launcher {}
}
