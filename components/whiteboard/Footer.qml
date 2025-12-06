import QtQuick
import QtQuick.Controls 2.15

/**
 * 白板底部工具栏组件
 * 按照Figma设计实现
 */
Rectangle {
    id: footer
    
    height: 48
    color: "#242424"
    
    // 顶部边框线
    Rectangle {
        id: topBorder
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: Qt.rgba(255, 255, 255, 0.1)
    }
    
    Row {
        id: leftButtons
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 5
        spacing: 0
        
        // 文件夹按钮
        Rectangle {
            id: folderButton
            width: 60
            height: 38
            color: folderMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
            radius: 4
            
            Column {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                spacing: 2
                
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/folder.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "文件夹"
                    font.pixelSize: 10
                    font.family: "PingFang SC"
                    color: Qt.rgba(255, 255, 255, 0.7)
                }
            }
            
            MouseArea {
                id: folderMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("文件夹")
                    footer.folderClicked()
                }
            }
        }
    }
    
    Row {
        id: rightButtons
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 5
        spacing: 0
        
        // 登录按钮
        Rectangle {
            id: loginButton
            width: 60
            height: 38
            color: loginMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
            radius: 4
            
            Column {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                spacing: 2
                
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/login.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "登录"
                    font.pixelSize: 10
                    font.family: "PingFang SC"
                    color: Qt.rgba(255, 255, 255, 0.7)
                }
            }
            
            MouseArea {
                id: loginMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("登录")
                    footer.loginClicked()
                }
            }
        }
        
        // 桌面按钮
        Rectangle {
            id: desktopButton
            width: 60
            height: 38
            color: desktopMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
            radius: 4
            
            Column {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                spacing: 2
                
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/desktop.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "桌面"
                    font.pixelSize: 10
                    font.family: "PingFang SC"
                    color: Qt.rgba(255, 255, 255, 0.7)
                }
            }
            
            MouseArea {
                id: desktopMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("桌面")
                    footer.desktopClicked()
                }
            }
        }
        
        // 设置按钮
        Rectangle {
            id: settingsButton
            width: 60
            height: 38
            color: settingsMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
            radius: 4
            
            Column {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                spacing: 2
                
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/settings.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "设置"
                    font.pixelSize: 10
                    font.family: "PingFang SC"
                    color: Qt.rgba(255, 255, 255, 0.7)
                }
            }
            
            MouseArea {
                id: settingsMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("设置")
                    footer.settingsClicked()
                }
            }
        }
        
        // 关闭板书按钮
        Rectangle {
            id: closeButton
            width: 100
            height: 38
            color: "transparent"
            border.color: "#e85c5c"
            border.width: 1
            radius: 4
            
            Text {
                anchors.centerIn: parent
                text: "关闭板书"
                font.pixelSize: 14
                font.family: "PingFang SC"
                color: "#e85c5c"
            }
            
            MouseArea {
                id: closeMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("关闭板书")
                    footer.closeClicked()
                }
            }
        }
    }
    
    // 信号定义
    signal folderClicked()
    signal loginClicked()
    signal desktopClicked()
    signal settingsClicked()
    signal closeClicked()
}

