import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Window
import "../components"
import "../components/whiteboard/"

Page {
    id: whiteboardPage
    
    // 接收从 StackView 传递的 router 对象和主窗口对象
    property var router: null
    property var mainWindow: null
    
    title: qsTr("白板")
    
    // 白板画布区域 - 深灰色背景
    Rectangle {
        id: canvas
        anchors.fill: parent
        anchors.bottomMargin: 48  // 为底部 Footer 留出空间
        color: "#242424"
        
        // 绘制画布组件（支持压感笔锋）
        DrawingCanvas {
            id: drawingCanvas
            anchors.fill: parent
            anchors.rightMargin: 48  // 为右侧工具栏留出空间
        }
        
        // 右侧工具栏
        ToolList {
            id: toolList
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            
            onUndo: {
                console.log("撤销操作")
                // TODO: 实现撤销功能
            }
            
            onRedo: {
                console.log("重做操作")
                // TODO: 实现重做功能
            }
            
            onPencil: {
                console.log("选择铅笔工具")
                // TODO: 切换到铅笔工具
            }
            
            onHighlighter: {
                console.log("选择高亮工具")
                // TODO: 切换到高亮工具
            }
            
            onEraser: {
                console.log("选择橡皮擦工具")
                // TODO: 切换到橡皮擦工具
            }
            
            onColorPicker: {
                console.log("选择颜色")
                // TODO: 打开颜色选择器
            }
            
            onCopy: {
                console.log("复制")
                // TODO: 实现复制功能
            }
            
            onScale: {
                console.log("缩放")
                // TODO: 实现缩放功能
            }
            
            onSave: {
                console.log("保存白板")
                // TODO: 实现保存功能
            }
        }
    }
    
    // 底部 Footer
    Footer {
        id: footer
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        
        onFolderClicked: {
            console.log("文件夹按钮被点击")
            // TODO: 实现文件夹功能
        }
        
        onLoginClicked: {
            console.log("登录按钮被点击")
            // TODO: 实现登录功能
        }
        
        onDesktopClicked: {
            console.log("桌面按钮被点击")
            // 最小化窗口，回到桌面
            if (mainWindow) {
                if (typeof mainWindow.showMinimized === "function") {
                    mainWindow.showMinimized()
                } else if (mainWindow.hasOwnProperty("visibility")) {
                    mainWindow.visibility = Window.Minimized
                } else {
                    console.log("无法最小化窗口：窗口对象不支持最小化操作")
                }
            } else {
                console.log("无法最小化窗口：未找到主窗口对象")
            }
        }
        
        onSettingsClicked: {
            console.log("设置按钮被点击")
            // TODO: 实现设置功能
        }
        
        onCloseClicked: {
            console.log("关闭板书按钮被点击")
            if (router) {
                router.goBack()
            }
        }
    }
}

