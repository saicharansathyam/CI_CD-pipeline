import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: dashboard
    
    GridLayout {
        anchors.fill: parent
        anchors.margins: 30
        columns: 2
        rowSpacing: 20
        columnSpacing: 20
        
        // Speed Gauge
        SpeedGauge {
            id: speedGauge
            Layout.fillWidth: true
            Layout.fillHeight: true
            value: headUnit.speed
            maxValue: 260
            unit: "km/h"
            label: "SPEED"
        }
        
        // RPM Gauge
        SpeedGauge {
            id: rpmGauge
            Layout.fillWidth: true
            Layout.fillHeight: true
            value: headUnit.rpm
            maxValue: 8000
            unit: "RPM"
            label: "ENGINE"
            gaugeColor: "#ff6b6b"
        }
        
        // Fuel Level
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: "#1e1e2e"
            radius: 10
            border.color: "#00ff9f"
            border.width: 1
            
            Column {
                anchors.centerIn: parent
                spacing: 10
                
                Text {
                    text: "FUEL LEVEL"
                    color: "#00ff9f"
                    font.pixelSize: 14
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: headUnit.fuelLevel.toFixed(1) + "%"
                    color: headUnit.fuelLevel < 20 ? "#ff6b6b" : "white"
                    font.pixelSize: 32
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Rectangle {
                    width: 200
                    height: 10
                    color: "#333"
                    radius: 5
                    
                    Rectangle {
                        width: parent.width * (headUnit.fuelLevel / 100)
                        height: parent.height
                        radius: 5
                        color: {
                            if (headUnit.fuelLevel < 20) return "#ff6b6b"
                            if (headUnit.fuelLevel < 50) return "#ffaa00"
                            return "#00ff9f"
                        }
                        
                        Behavior on width {
                            NumberAnimation { duration: 500 }
                        }
                    }
                }
            }
        }
        
        // Temperature
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: "#1e1e2e"
            radius: 10
            border.color: "#00aaff"
            border.width: 1
            
            Column {
                anchors.centerIn: parent
                spacing: 10
                
                Text {
                    text: "TEMPERATURE"
                    color: "#00aaff"
                    font.pixelSize: 14
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: headUnit.temperature.toFixed(1) + "°C"
                    color: "white"
                    font.pixelSize: 32
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: {
                        if (headUnit.temperature < 0) return "❄ Cold"
                        if (headUnit.temperature < 15) return "🌤 Cool"
                        if (headUnit.temperature < 25) return "☀ Normal"
                        return "🔥 Hot"
                    }
                    color: "#00aaff"
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
