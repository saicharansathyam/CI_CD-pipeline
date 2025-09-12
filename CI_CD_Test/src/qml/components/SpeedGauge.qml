import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    
    property real value: 0
    property real maxValue: 100
    property string unit: ""
    property string label: ""
    property color gaugeColor: "#00ff9f"
    
    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        radius: 10
        border.color: gaugeColor
        border.width: 1
        
        Item {
            anchors.fill: parent
            anchors.margins: 20
            
            // Circular gauge background
            Canvas {
                id: gaugeCanvas
                anchors.fill: parent
                
                property real angleStart: -220
                property real angleEnd: 40
                property real currentAngle: angleStart + (value / maxValue) * (angleEnd - angleStart)
                
                onCurrentAngleChanged: requestPaint()
                
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    
                    var centerX = width / 2
                    var centerY = height / 2
                    var radius = Math.min(width, height) / 2 - 20
                    
                    // Draw background arc
                    ctx.beginPath()
                    ctx.arc(centerX, centerY, radius, 
                           (angleStart - 90) * Math.PI / 180,
                           (angleEnd - 90) * Math.PI / 180)
                    ctx.strokeStyle = "#333"
                    ctx.lineWidth = 15
                    ctx.stroke()
                    
                    // Draw value arc
                    ctx.beginPath()
                    ctx.arc(centerX, centerY, radius,
                           (angleStart - 90) * Math.PI / 180,
                           (currentAngle - 90) * Math.PI / 180)
                    ctx.strokeStyle = gaugeColor
                    ctx.lineWidth = 15
                    ctx.lineCap = "round"
                    ctx.stroke()
                    
                    // Draw tick marks
                    ctx.strokeStyle = "#666"
                    ctx.lineWidth = 2
                    for (var i = 0; i <= 10; i++) {
                        var angle = angleStart + i * (angleEnd - angleStart) / 10
                        var angleRad = (angle - 90) * Math.PI / 180
                        
                        var x1 = centerX + Math.cos(angleRad) * (radius - 5)
                        var y1 = centerY + Math.sin(angleRad) * (radius - 5)
                        var x2 = centerX + Math.cos(angleRad) * (radius + 5)
                        var y2 = centerY + Math.sin(angleRad) * (radius + 5)
                        
                        ctx.beginPath()
                        ctx.moveTo(x1, y1)
                        ctx.lineTo(x2, y2)
                        ctx.stroke()
                    }
                }
                
                Behavior on currentAngle {
                    NumberAnimation { duration: 500; easing.type: Easing.OutQuad }
                }
            }
            
            // Center display
            Column {
                anchors.centerIn: parent
                spacing: 5
                
                Text {
                    text: label
                    color: gaugeColor
                    font.pixelSize: 14
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: Math.round(value)
                    color: "white"
                    font.pixelSize: 48
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: unit
                    color: "#999"
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
