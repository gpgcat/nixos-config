import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

Row {
  spacing: 10

  FontText {
    textColor: textColor
    label: Pipewire.defaultAudioSink?.audio ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%" : "N/A"
    anchors.verticalCenter: parent.verticalCenter
  }

  Slider {
    width: 100

    from: 0.0
    to: 1.0
            
    value: Pipewire.defaultAudioSink?.audio?.volume ?? 0

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.NoButton
        
      onWheel: (wheel) => {
        if (Pipewire.defaultAudioSink?.audio) {
          let step = 0.05
          let current = Pipewire.defaultAudioSink.audio.volume
          let next = wheel.angleDelta.y > 0 
            ? Math.min(1.0, current + step) 
            : Math.max(0.0, current - step)
              
          Pipewire.defaultAudioSink.audio.volume = next
        }
      }
    }
          
    onMoved: {
      if (Pipewire.defaultAudioSink?.audio) {
        Pipewire.defaultAudioSink.audio.volume = value
      }
    }

    background: Rectangle {
      implicitWidth: 100
      implicitHeight: 6
      y: (parent.height - height) / 2
      color: bar.volumeSliderBackground
      radius: 0
    }
    
    handle: Rectangle {
      x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
      y: (parent.height - height) / 2
      implicitWidth: 16
      implicitHeight: 16
      color: bar.volumeSliderHandle
      radius: 0
    }
  }
}
