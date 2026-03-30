import Quickshell.Services.Mpris
import QtQuick

Row {
  spacing: 10
  visible: bar.player !== null

  Row {
    spacing: 5
  
    Rectangle {
      width: 20
      height: 20
      clip: true
  
      Image {
        anchors.fill: parent
        source: bar.player?.metadata?.artUrl ?? ""
        fillMode: Image.PreserveAspectCrop
      }
    }
  
    FontText {
      anchors.verticalCenter: parent.verticalCenter
  
      textColor: bar.textColor
      label: (bar.player?.metadata?.artist ?? "artist") + " - " + (bar.player?.metadata?.title ?? "title")
    }
  }
  
  Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5
  
    FontText {
      label: "⏮"
      textColor: textColor
      MouseArea { anchors.fill: parent; onClicked: bar.player?.previous() }
    }
  
    FontText {
      anchors.verticalCenter: parent.verticalCenter
      label: bar.player?.playbackStatus === Mpris.Playing ? "||" : "▶"
      textColor: textColor
      MouseArea { anchors.fill: parent; onClicked: bar.player?.playPause() }
    }
  
    FontText {
      label: "⏭"
      textColor: textColor
      MouseArea { anchors.fill: parent; onClicked: bar.player?.next() }
    }
  }
}
