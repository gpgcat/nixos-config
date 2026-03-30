import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

RowLayout {
  Layout.rightMargin: 2
  Layout.leftMargin: 2
  Layout.topMargin: 5
  Layout.bottomMargin: 5
      
  FontText {
    textColor: nc.textColor
    label: Pipewire.defaultAudioSink?.audio ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%" : "N/A"
  }

  Slider {
    Layout.fillWidth: true
    implicitHeight: 16
    
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
      implicitHeight: 6
      height: 6
      anchors.verticalCenter: parent.verticalCenter
      color: nc.volumeSliderBackground
      radius: 0
    }
    
    handle: Rectangle {
      x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
      y: (parent.height - height) / 2
      implicitWidth: 16
      implicitHeight: 16
      color: nc.volumeSliderHandle
      radius: 0
    }
  }
}

