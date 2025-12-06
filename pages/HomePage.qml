import QtQuick
import QtQuick.Controls 2.15
import "../components"

Page {
    id: homePage
    
    // 接收从 StackView 传递的 router 对象
    property var router: null
    
    title: qsTr("首页")
    
    header: ToolBar {
        Label {
            anchors.centerIn: parent
            text: homePage.title
            font.pixelSize: 18
            font.bold: true
        }
    }
    
    Column {
        anchors.centerIn: parent
        spacing: 20
        
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("欢迎使用 Qt Quick 应用")
            font.pixelSize: 24
            font.bold: true
        }
        
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("前往关于页面")
            onClicked: {
                if (router) {
                    router.navigate("AboutPage")
                }
            }
        }
        
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("前往设置页面")
            onClicked: {
                if (router) {
                    router.navigate("SettingsPage")
                }
            }
        }
    }
}

