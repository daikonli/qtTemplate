import QtQuick
import QtQuick.Controls 2.15

/**
 * 卡片组件 - 可复用的卡片容器
 */
Rectangle {
    id: card
    
    property alias title: titleLabel.text
    property alias content: contentContainer.children
    
    default property alias contentData: contentContainer.data
    
    radius: 8
    color: "#FFFFFF"
    border.color: "#E0E0E0"
    border.width: 1
    
    Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12
        
        Label {
            id: titleLabel
            font.pixelSize: 18
            font.bold: true
            visible: text !== ""
        }
        
        Item {
            id: contentContainer
            width: parent.width
            height: childrenRect.height
        }
    }
}

