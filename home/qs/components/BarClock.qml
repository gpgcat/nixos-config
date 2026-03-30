import QtQuick

FontText {
  textColor: textColor
  label: Qt.formatDateTime(clock.date, "hh:mm:ss ap - MM/dd/yyyy")
}
