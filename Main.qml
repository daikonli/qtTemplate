import QtQuick
import QtQuick.Controls 2.15
import QtQuick.VirtualKeyboard
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 1440
    height: 810
    visible: true
    title: qsTr("Qt Quick App")
    // visibility: Window.FullScreen

    // 路由管理器
    Router {
        id: router
        stackView: stackView
        mainWindow: window
    }

    // 主内容区域 - 使用 StackView 进行页面导航
    StackView {
        id: stackView
        anchors.fill: parent
        
        Component.onCompleted: {
            // 加载初始页面并传递 router 和 mainWindow 引用
            push("pages/HomePage.qml", {"router": router, "mainWindow": window})
        }
    }

    // 虚拟键盘支持
    InputPanel {
        id: inputPanel
        z: 99
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                inputPanel.y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            NumberAnimation {
                properties: "y"
                easing.type: Easing.InOutQuad
            }
        }
    }
}
