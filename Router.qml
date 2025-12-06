import QtQuick
import QtQuick.Controls 2.15

/**
 * 路由管理器组件
 * 提供页面导航功能，类似 React Router
 */
Item {
    id: router
    
    property StackView stackView: null
    property var mainWindow: null
    
    /**
     * 导航到指定页面
     * @param pageName 页面名称（相对于 pages 目录的路径，不含 .qml 后缀）
     * @param properties 传递给页面的属性对象
     */
    function navigate(pageName, properties) {
        if (!stackView) {
            console.error("Router: stackView not set")
            return
        }
        
        var pagePath = "pages/" + pageName + ".qml"
        var pageProperties = properties || {}
        // 确保每个页面都能访问 router 和 mainWindow
        pageProperties.router = router
        pageProperties.mainWindow = mainWindow
        stackView.push(pagePath, pageProperties)
    }
    
    /**
     * 返回上一页
     */
    function goBack() {
        if (stackView && stackView.depth > 1) {
            stackView.pop()
        }
    }
    
    /**
     * 返回到根页面
     */
    function goToRoot() {
        if (stackView) {
            stackView.pop(null, StackView.Immediate)
        }
    }
    
    /**
     * 替换当前页面
     */
    function replace(pageName, properties) {
        if (!stackView) {
            console.error("Router: stackView not set")
            return
        }
        
        var pagePath = "pages/" + pageName + ".qml"
        var pageProperties = properties || {}
        // 确保每个页面都能访问 router 和 mainWindow
        pageProperties.router = router
        pageProperties.mainWindow = mainWindow
        stackView.replace(pagePath, pageProperties)
    }
}

