import QtQuick
import QtQuick.Controls 2.15

/**
 * 白板右侧工具栏组件
 * 按照Figma设计实现
 */
Item {
    id: toolList
    
    width: 48
    height: 434
    
    // 上方工具栏区域（撤销/重做）
    Rectangle {
        id: topToolbar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 100
        color: Qt.rgba(255, 255, 255, 0.05)
        radius: 4
        border.width: 0
        
        Column {
            anchors.fill: parent
            anchors.topMargin: 4
            spacing: 0
            
            // 撤销按钮
            Rectangle {
                id: undoButton
                width: 48
                height: 46
                color: undoMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/undo.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: undoMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("撤销")
                        toolList.undo()
                    }
                }
            }
            
            // 重做按钮
            Rectangle {
                id: redoButton
                width: 48
                height: 46
                color: redoMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/redo.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: redoMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("重做")
                        toolList.redo()
                    }
                }
            }
        }
    }
    
    // 下方工具栏区域（工具按钮）
    Rectangle {
        id: bottomToolbar
        anchors.top: topToolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Qt.rgba(255, 255, 255, 0.05)
        radius: 4
        border.width: 0
        
        Column {
            anchors.fill: parent
            anchors.topMargin: 4
            spacing: 0
            
            // 铅笔工具
            Rectangle {
                id: pencilButton
                width: 48
                height: 46
                color: pencilMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/pencil.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: pencilMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("铅笔工具")
                        toolList.pencil()
                    }
                }
            }
            
            // 高亮工具
            Rectangle {
                id: highlighterButton
                width: 48
                height: 46
                color: highlighterMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/highlighter.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: highlighterMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("高亮工具")
                        toolList.highlighter()
                    }
                }
            }
            
            // 橡皮擦工具
            Rectangle {
                id: eraserButton
                width: 48
                height: 46
                color: eraserMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/eraser.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: eraserMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("橡皮擦工具")
                        toolList.eraser()
                    }
                }
            }
            
            // 颜色选择工具
            Rectangle {
                id: colorPickerButton
                width: 48
                height: 46
                color: colorPickerMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/colorpicker.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: colorPickerMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("颜色选择工具")
                        toolList.colorPicker()
                    }
                }
            }
            
            // 复制工具
            Rectangle {
                id: copyButton
                width: 48
                height: 46
                color: copyMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/copy.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: copyMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("复制工具")
                        toolList.copy()
                    }
                }
            }
            
            // 缩放工具
            Rectangle {
                id: scaleButton
                width: 48
                height: 46
                color: scaleMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/scale.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: scaleMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("缩放工具")
                        toolList.scale()
                    }
                }
            }
            
            // 保存工具
            Rectangle {
                id: saveButton
                width: 48
                height: 46
                color: saveMouseArea.containsMouse ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                
                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 11
                    width: 24
                    height: 24
                    source: "qrc:/qt/qml/qtTemplate/assets/icons/whiteboard/save.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    id: saveMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("保存工具")
                        toolList.save()
                    }
                }
            }
        }
    }
    
    // 信号定义
    signal undo()
    signal redo()
    signal pencil()
    signal highlighter()
    signal eraser()
    signal colorPicker()
    signal copy()
    signal scale()
    signal save()
}

