import QtQuick
import QtQuick.Controls 2.15
import "../components"

Page {
    id: settingsPage
    
    // 接收从 StackView 传递的 router 对象
    property var router: null
    
    title: qsTr("设置")
    
    header: ToolBar {
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            
            ToolButton {
                text: "←"
                font.pixelSize: 20
                onClicked: {
                    if (router) {
                        router.goBack()
                    }
                }
            }
        }
        
        Label {
            anchors.centerIn: parent
            text: settingsPage.title
            font.pixelSize: 18
            font.bold: true
        }
    }
    
    ScrollView {
        anchors.fill: parent
        
        Column {
            width: settingsPage.width
            spacing: 20
            padding: 20
            
            Label {
                text: qsTr("应用设置")
                font.pixelSize: 20
                font.bold: true
            }
            
            Switch {
                text: qsTr("启用通知")
                checked: true
            }
            
            Switch {
                text: qsTr("深色模式")
            }
            
            ComboBox {
                width: parent.width
                model: [qsTr("简体中文"), qsTr("English"), qsTr("日本語")]
                currentIndex: 0
            }
            
            Button {
                width: parent.width
                text: qsTr("保存设置")
                highlighted: true
            }
        }
    }
}

