import QtQuick
import QtQuick.Controls 2.15

/**
 * 白板绘制画布组件
 * 支持压感笔锋效果
 */
Canvas {
    id: drawingCanvas
    
    // 绘制状态
    property bool drawing: false
    property point lastPoint: Qt.point(0, 0)
    property var paths: []  // 存储所有路径，每个路径包含点和压力信息
    
    // 画笔属性
    property color strokeColor: "#FFFFFF"
    property real minLineWidth: 1.0
    property real maxLineWidth: 10.0
    property real baseLineWidth: 3.0
    
    // 路径数据结构：{points: [point...], pressures: [real...]}
    
    onPaint: {
        var ctx = getContext("2d")
        
        // 填充背景
        ctx.fillStyle = "#000000"
        ctx.fillRect(0, 0, width, height)
        
        // 设置填充样式（因为使用 fill() 而不是 stroke()）
        ctx.fillStyle = strokeColor
        ctx.lineCap = "round"
        ctx.lineJoin = "round"
        
        // 绘制所有路径
        for (var i = 0; i < paths.length; i++) {
            var path = paths[i]
            if (!path.points || path.points.length === 0) {
                continue
            }
            
            var points = path.points
            var pressures = path.pressures || []
            
            // 如果只有一个点，绘制一个圆
            if (points.length === 1) {
                var pressure = pressures.length > 0 ? pressures[0] : 0.5
                var radius = minLineWidth + (maxLineWidth - minLineWidth) * pressure
                ctx.beginPath()
                ctx.arc(points[0].x, points[0].y, radius / 2, 0, 2 * Math.PI)
                ctx.fill()
                continue
            }
            
            // 如果只有两个点且距离很近，也要绘制第一个点
            if (points.length === 2) {
                var p1 = points[0]
                var p2 = points[1]
                var dx = p2.x - p1.x
                var dy = p2.y - p1.y
                var distance = Math.sqrt(dx * dx + dy * dy)
                
                // 如果距离太近，只绘制第一个点
                if (distance < 0.1) {
                    var pressure1 = pressures.length > 0 ? pressures[0] : 0.5
                    var radius1 = minLineWidth + (maxLineWidth - minLineWidth) * pressure1
                    ctx.beginPath()
                    ctx.arc(p1.x, p1.y, radius1 / 2, 0, 2 * Math.PI)
                    ctx.fill()
                    continue
                }
            }
            
            // 绘制带压感的线条（使用更平滑的笔锋效果）
            for (var j = 0; j < points.length - 1; j++) {
                var p1 = points[j]
                var p2 = points[j + 1]
                var pressure1 = pressures.length > j ? pressures[j] : 0.5
                var pressure2 = pressures.length > j + 1 ? pressures[j + 1] : 0.5
                
                var width1 = minLineWidth + (maxLineWidth - minLineWidth) * pressure1
                var width2 = minLineWidth + (maxLineWidth - minLineWidth) * pressure2
                
                // 计算两点之间的距离和角度
                var dx = p2.x - p1.x
                var dy = p2.y - p1.y
                var distance = Math.sqrt(dx * dx + dy * dy)
                
                if (distance < 0.1) {
                    continue
                }
                
                var angle = Math.atan2(dy, dx)
                
                // 计算垂直于线条的方向向量
                var perpX = -Math.sin(angle)
                var perpY = Math.cos(angle)
                
                // 绘制渐变粗细的线段（使用填充的四边形模拟笔锋）
                ctx.beginPath()
                ctx.moveTo(p1.x + perpX * width1 / 2, p1.y + perpY * width1 / 2)
                ctx.lineTo(p1.x - perpX * width1 / 2, p1.y - perpY * width1 / 2)
                ctx.lineTo(p2.x - perpX * width2 / 2, p2.y - perpY * width2 / 2)
                ctx.lineTo(p2.x + perpX * width2 / 2, p2.y + perpY * width2 / 2)
                ctx.closePath()
                ctx.fill()
            }
        }
    }
    
    // 计算压力值（基于移动速度模拟压感）
    function calculatePressure(point, lastPoint, lastTime, currentTime) {
        if (!lastPoint || lastTime === 0) {
            return 0.8  // 初始压力
        }
        
        var dx = point.x - lastPoint.x
        var dy = point.y - lastPoint.y
        var distance = Math.sqrt(dx * dx + dy * dy)
        var timeDelta = currentTime - lastTime
        
        if (timeDelta <= 0) {
            return 0.5
        }
        
        // 速度 = 距离 / 时间
        var speed = distance / timeDelta
        
        // 速度越快，压力越小（线条越细）
        // 速度越慢，压力越大（线条越粗）
        // 将速度映射到 0-1 的压力值
        var maxSpeed = 50  // 最大速度阈值
        var normalizedSpeed = Math.min(speed / maxSpeed, 1.0)
        var pressure = 1.0 - normalizedSpeed * 0.6  // 压力范围：0.4 - 1.0
        
        return Math.max(0.3, Math.min(1.0, pressure))
    }
    
    // 触摸事件处理（支持压感）
    MultiPointTouchArea {
        anchors.fill: parent
        maximumTouchPoints: 1
        
        property var currentPath: null
        property point lastTouchPoint: Qt.point(0, 0)
        property int lastTouchTime: 0
        
        onPressed: {
            if (touchPoints.length > 0) {
                var touch = touchPoints[0]
                var point = Qt.point(touch.x, touch.y)
                var currentTime = Date.now()
                
                drawingCanvas.drawing = true
                lastTouchPoint = point
                lastTouchTime = currentTime
                
                // 创建新路径
                currentPath = {
                    points: [point],
                    pressures: [0.8]  // 初始压力
                }
                drawingCanvas.paths.push(currentPath)
                
                // 立即触发重绘，确保第一个点能显示
                drawingCanvas.requestPaint()
            }
        }
        
        onTouchUpdated: {
            if (drawingCanvas.drawing && touchPoints.length > 0 && currentPath) {
                var touch = touchPoints[0]
                var point = Qt.point(touch.x, touch.y)
                var currentTime = Date.now()
                
                // 计算与上一个点的距离
                var dx = point.x - lastTouchPoint.x
                var dy = point.y - lastTouchPoint.y
                var distance = Math.sqrt(dx * dx + dy * dy)
                
                // 如果距离太小，不添加新点（避免点过多），但确保第一个点已显示
                if (distance < 0.5 && currentPath.points.length > 1) {
                    return
                }
                
                // 计算压力（如果有压感支持，使用实际压力；否则基于速度模拟）
                var pressure = 0.5
                if (touch.pressure !== undefined && touch.pressure > 0) {
                    // 使用实际的触摸压力
                    pressure = touch.pressure
                } else {
                    // 基于速度模拟压力
                    pressure = calculatePressure(point, lastTouchPoint, lastTouchTime, currentTime)
                }
                
                // 添加点到路径
                currentPath.points.push(point)
                currentPath.pressures.push(pressure)
                
                lastTouchPoint = point
                lastTouchTime = currentTime
                
                drawingCanvas.requestPaint()
            }
        }
        
        onReleased: {
            drawingCanvas.drawing = false
            currentPath = null
        }
    }
    
    // 鼠标事件处理（作为触摸的备选方案，优先使用触摸）
    MouseArea {
        anchors.fill: parent
        enabled: !drawingCanvas.drawing  // 如果正在触摸绘制，禁用鼠标
        
        property point lastMousePoint: Qt.point(0, 0)
        property int lastMouseTime: 0
        property var currentMousePath: null
        
        onPressed: function(mouse) {
            // 只有在没有触摸输入时才使用鼠标
            if (!drawingCanvas.drawing) {
                drawingCanvas.drawing = true
                var point = Qt.point(mouse.x, mouse.y)
                var currentTime = Date.now()
                lastMousePoint = point
                lastMouseTime = currentTime
                
                // 创建新路径
                currentMousePath = {
                    points: [point],
                    pressures: [0.8]  // 初始压力
                }
                drawingCanvas.paths.push(currentMousePath)
                
                // 立即触发重绘，确保第一个点能显示
                drawingCanvas.requestPaint()
            }
        }
        
        onPositionChanged: function(mouse) {
            if (drawingCanvas.drawing && currentMousePath) {
                var point = Qt.point(mouse.x, mouse.y)
                var currentTime = Date.now()
                
                // 计算与上一个点的距离
                var dx = point.x - lastMousePoint.x
                var dy = point.y - lastMousePoint.y
                var distance = Math.sqrt(dx * dx + dy * dy)
                
                // 如果距离太小，不添加新点（避免点过多），但确保第一个点已显示
                if (distance < 0.5 && currentMousePath.points.length > 1) {
                    return
                }
                
                // 基于速度模拟压力
                var pressure = calculatePressure(point, lastMousePoint, lastMouseTime, currentTime)
                
                // 添加点到路径
                currentMousePath.points.push(point)
                currentMousePath.pressures.push(pressure)
                
                lastMousePoint = point
                lastMouseTime = currentTime
                
                drawingCanvas.requestPaint()
            }
        }
        
        onReleased: function(mouse) {
            if (currentMousePath) {
                drawingCanvas.drawing = false
                currentMousePath = null
            }
        }
    }
    
    // 清除画布
    function clearCanvas() {
        paths = []
        requestPaint()
    }
    
    // 撤销最后一条路径
    function undoLastPath() {
        if (paths.length > 0) {
            paths.pop()
            requestPaint()
        }
    }
    
    // 获取路径数量
    function getPathCount() {
        return paths.length
    }
}

