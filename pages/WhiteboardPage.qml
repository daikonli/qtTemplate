import QtQuick
import QtQuick.Controls 2.15
import "../components"
import "../components/whiteboard/"

Page {
    id: whiteboardPage
    
    // 接收从 StackView 传递的 router 对象
    property var router: null
    
    title: qsTr("白板")
    
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
            text: whiteboardPage.title
            font.pixelSize: 18
            font.bold: true
        }
    }
    
    // 白板画布区域 - 黑色背景
    Rectangle {
        id: canvas
        anchors.fill: parent
        color: "#000000"
        
        Canvas {
            id: drawingCanvas
            anchors.fill: parent
            anchors.rightMargin: 48  // 为右侧工具栏留出空间
            
            property bool drawing: false
            property point lastPoint: Qt.point(0, 0)
            property var paths: []
            
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "#000000"
                ctx.fillRect(0, 0, width, height)
                
                ctx.strokeStyle = "#FFFFFF"
                ctx.lineWidth = 3
                ctx.lineCap = "round"
                ctx.lineJoin = "round"
                
                // 绘制所有路径
                for (var i = 0; i < paths.length; i++) {
                    var path = paths[i]
                    if (path.length > 0) {
                        ctx.beginPath()
                        ctx.moveTo(path[0].x, path[0].y)
                        for (var j = 1; j < path.length; j++) {
                            ctx.lineTo(path[j].x, path[j].y)
                        }
                        ctx.stroke()
                    }
                }
            }
            
            MouseArea {
                anchors.fill: parent
                
                onPressed: {
                    drawingCanvas.drawing = true
                    drawingCanvas.lastPoint = Qt.point(mouse.x, mouse.y)
                    var newPath = [Qt.point(mouse.x, mouse.y)]
                    drawingCanvas.paths.push(newPath)
                }
                
                onPositionChanged: {
                    if (drawingCanvas.drawing && drawingCanvas.paths.length > 0) {
                        var currentPath = drawingCanvas.paths[drawingCanvas.paths.length - 1]
                        currentPath.push(Qt.point(mouse.x, mouse.y))
                        drawingCanvas.requestPaint()
                    }
                }
                
                onReleased: {
                    drawingCanvas.drawing = false
                }
            }
            
            // 清除画布功能
            function clearCanvas() {
                paths = []
                requestPaint()
            }
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
}

