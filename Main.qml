import QtQuick
import QtQuick.Controls 2.15
import QtQuick.VirtualKeyboard
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Qt Quick App")

    // 路由管理器
    Router {
        id: router
        stackView: stackView
    }

    // 主内容区域 - 使用 StackView 进行页面导航
    StackView {
        id: stackView
        anchors.fill: parent
        
        Component.onCompleted: {
            // 加载初始页面并传递 router 引用
            push("pages/HomePage.qml", {"router": router})
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
