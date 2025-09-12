import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1280
    height: 800
    title: qsTr("DES Head Unit - ") + headUnit.currentProfile + " Profile"
    
    Material.theme: Material.Dark
    Material.accent: Material.Blue
    
    // Background gradient
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1a1a2e" }
            GradientStop { position: 1.0; color: "#0f0f1e" }
        }
    }
    
    // Header Bar
    Rectangle {
        id: headerBar
        width: parent.width
        height: 80
        color: "#16213e"
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            
            // DES Logo/Title
            Text {
                text: "DES HEAD UNIT"
                font.pixelSize: 24
                font.bold: true
                color: "#00ff9f"
                font.family: "Arial"
            }
            
            Item { Layout.fillWidth: true }
            
            // Status indicators
            Row {
                spacing: 20
                
                // System Status
                Rectangle {
                    width: 12
                    height: 12
                    radius: 6
                    color: headUnit.systemReady ? "#00ff00" : "#ff0000"
                    
                    SequentialAnimation on opacity {
                        running: true
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.3; duration: 500 }
                        NumberAnimation { to: 1.0; duration: 500 }
                    }
                }
                
                Text {
                    text: headUnit.systemReady ? "SYSTEM READY" : "INITIALIZING..."
                    color: headUnit.systemReady ? "#00ff00" : "#ffaa00"
                    font.pixelSize: 14
                }
                
                Text {
                    text: "|"
                    color: "#666"
                    font.pixelSize: 16
                }
                
                // Profile indicator
                Text {
                    text: "PROFILE: " + headUnit.currentProfile
                    color: "#00aaff"
                    font.pixelSize: 14
                    font.bold: true
                }
            }
        }
    }
    
    // Main Content
    SwipeView {
        id: swipeView
        anchors.top: headerBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bottomBar.top
        currentIndex: 0
        
        // Dashboard Page
        Dashboard {
            id: dashboardPage
        }
        
        // Settings Page
        Item {
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                
                Column {
                    anchors.centerIn: parent
                    spacing: 30
                    
                    Text {
                        text: "SETTINGS"
                        font.pixelSize: 36
                        color: "#00ff9f"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    // Profile Selection
                    Column {
                        spacing: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        
                        Text {
                            text: "Select Profile:"
                            color: "white"
                            font.pixelSize: 18
                        }
                        
                        Row {
                            spacing: 10
                            
                            Button {
                                text: "IVI"
                                width: 100
                                highlighted: headUnit.currentProfile === "IVI"
                                onClicked: headUnit.switchProfile("IVI")
                            }
                            
                            Button {
                                text: "IC"
                                width: 100
                                highlighted: headUnit.currentProfile === "IC"
                                onClicked: headUnit.switchProfile("IC")
                            }
                            
                            Button {
                                text: "Standard"
                                width: 100
                                highlighted: headUnit.currentProfile === "Standard"
                                onClicked: headUnit.switchProfile("Standard")
                            }
                        }
                    }
                }
            }
        }
        
        // Info Page
        Item {
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                
                Column {
                    anchors.centerIn: parent
                    spacing: 20
                    
                    Text {
                        text: "SYSTEM INFORMATION"
                        font.pixelSize: 36
                        color: "#00ff9f"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    Rectangle {
                        width: 400
                        height: 1
                        color: "#00ff9f"
                    }
                    
                    Column {
                        spacing: 10
                        
                        Text {
                            text: "Version: 1.0.0"
                            color: "white"
                            font.pixelSize: 16
                        }
                        
                        Text {
                            text: "Platform: Automotive Head Unit"
                            color: "white"
                            font.pixelSize: 16
                        }
                        
                        Text {
                            text: "Profile: " + headUnit.currentProfile
                            color: "white"
                            font.pixelSize: 16
                        }
                        
                        Text {
                            text: "Status: " + (headUnit.systemReady ? "Online" : "Offline")
                            color: headUnit.systemReady ? "#00ff00" : "#ff0000"
                            font.pixelSize: 16
                        }
                    }
                }
            }
        }
    }
    
    // Bottom Navigation Bar
    Rectangle {
        id: bottomBar
        width: parent.width
        height: 80
        anchors.bottom: parent.bottom
        color: "#16213e"
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            
            Repeater {
                model: ["Dashboard", "Settings", "Info"]
                
                Button {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: modelData
                    font.pixelSize: 16
                    highlighted: swipeView.currentIndex === index
                    
                    onClicked: swipeView.currentIndex = index
                    
                    background: Rectangle {
                        color: parent.highlighted ? "#00ff9f" : "transparent"
                        opacity: parent.highlighted ? 0.2 : 1
                        border.color: parent.highlighted ? "#00ff9f" : "#666"
                        border.width: 2
                        radius: 8
                    }
                }
            }
        }
    }
    
    // System Messages
    Rectangle {
        id: messageBar
        width: parent.width * 0.6
        height: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: headerBar.bottom
        anchors.topMargin: 10
        color: "#2a2a3e"
        radius: 20
        visible: messageText.text !== ""
        opacity: 0
        
        Text {
            id: messageText
            anchors.centerIn: parent
            color: "#00ff9f"
            font.pixelSize: 14
        }
        
        SequentialAnimation {
            id: messageAnimation
            PropertyAnimation { target: messageBar; property: "opacity"; to: 1; duration: 200 }
            PauseAnimation { duration: 2000 }
            PropertyAnimation { target: messageBar; property: "opacity"; to: 0; duration: 200 }
            onStopped: messageText.text = ""
        }
    }
    
    Connections {
        target: headUnit
        function onSystemMessage(message) {
            messageText.text = message
            messageAnimation.start()
        }
    }
}
