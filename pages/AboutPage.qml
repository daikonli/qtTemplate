import QtQuick
import QtQuick.Controls 2.15
import "../components"

Page {
    id: aboutPage
    
    // 接收从 StackView 传递的 router 对象和主窗口对象
    property var router: null
    property var mainWindow: null
    
    title: qsTr("关于")
    
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
            text: aboutPage.title
            font.pixelSize: 18
            font.bold: true
        }
    }
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 20
        
        Column {
            width: aboutPage.width - 40
            spacing: 20
            
            Label {
                width: parent.width
                text: qsTr("关于应用")
                font.pixelSize: 22
                font.bold: true
            }
            
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: qsTr("这是一个使用 Qt Quick Controls 2 构建的应用程序。\n\n项目结构参考了 React 的标准目录划分：\n- assets: 存放静态资源\n- components: 存放可复用组件\n- pages: 存放页面组件")
            }
            
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: qsTr("版本: 1.0.0")
            }
        }
    }
}

