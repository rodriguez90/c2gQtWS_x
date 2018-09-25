// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "../common"

TabBar {
    id: myTabBar
    Layout.fillWidth: true
    currentIndex: 0
    onCurrentIndexChanged: {
        console.log("Tab Bar current index changed: "+ currentIndex)
        if(navSwipePane.currentIndex !== currentIndex) {
            navSwipePane.currentIndex = currentIndex
        }
    }

    Repeater {
        id: tabRepeater
        model: currentConference? currentConference.daysPropertyList.length : []
        TabButton {
            focusPolicy: Qt.NoFocus
            text: dataUtil.scheduleTabName(index)
            width: tabBarIsFixed? myTabBar.width / model.length  : Math.max(112, myTabBar.width / model.length)
        }
    } // repeater

    function onConferenceSwitched() {
        tabRepeater.model = []
        tabRepeater.model = currentConference.daysPropertyList.length
    }

    Connections {
        target: appWindow
        onConferenceSwitched: myTabBar.onConferenceSwitched()
    }

}
