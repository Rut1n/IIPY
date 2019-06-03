import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4

Window {
    Rectangle {
        id: rect1
        width: window1.width; height: window1.height
        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_1) {
                console.log('Key 1 was pressed');
                DmesgCall.blink_led()
                event.accepted = true;
            }
            if (event.key === Qt.Key_F1 ) {
                console.log('Key F1 was pressed');
                DmesgCall.revert_led()
                event.accepted = true;
            }
            if (event.key === Qt.Key_Up ) {
                console.log('Key Up was pressed');
                textArea.text = "Press Any key with LED"
                textArea.opacity = 1
                rect2.focus = true
                event.accepted = true
            }
        }
    }
    Rectangle {
        id: rect2
        width: window1.width; height: window1.height
        focus: false
        Keys.onPressed:{
            if (event.key === Qt.Key_CapsLock ) {
                console.log('Key Caps was pressed');
                textArea.text = "CapsLock is " + DmesgCall.booltostring(0)
                textArea.opacity = 1
                event.accepted = true;
            }
            if (event.key === Qt.Key_NumLock ) {
                console.log('Key Num was pressed');
                textArea.text = "NumLock is " + DmesgCall.booltostring(1)
                textArea.opacity = 1
                event.accepted = true;
            }
            if (event.key === Qt.Key_Down ) {
                console.log('Key Down was pressed');
                rect1.focus = true
                textArea.opacity = 0
                event.accepted = true
            }
        }
    }

    id: window1
    visible: true
    width: 640
    height: 480
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    title: qsTr("IIPU")

    Image {
        id: image
        x: 0
        y: 0
        width: 640
        height: 480
        z: 2
        visible: true
        source: "/images/defaulttt.jpeg"
        Keys.onEnterPressed: { image.visible = false }




        TextArea {
            backgroundVisible: false
            id: textArea
            clip: false
            opacity: 0
            anchors.left: parent.left
            anchors.leftMargin: 83
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 34
            anchors.right: parent.right
            anchors.rightMargin: 111
            readOnly: true
        }



        Window {
            id: w3
            visible: false
            width: 480
            height: 320
              x: (Screen.width - width) / 2
              y: (Screen.height - height) / 2
            MouseArea {

                id: mouseArea
                x: 83
                y: 87
                width: 327
                height: 218


                Button {
                    id: button1
                    x: 32
                    y: 85
                    text: qsTr("Нет")
                    onClicked: w3.hide()
                }

                Button {
                    id: button2
                    x: 171
                    y: 85
                    text: qsTr("Да")
                    onClicked: Qt.quit()
                }

                Text {
                    id: text1
                    x: 32
                    y: 19
                    width: 287
                    height: 252
                    text: qsTr(" Вы действительно хотите выйти?")
                    font.pixelSize: 21
                }
            }
        }




        Row {
            id: tools

            Button {

                id: bgch
                text: "Change BG"
                onClicked: {
                    fileDialog2.open()
                }
            }

            Button {
                id: dmsg
                x: 68
                text: "Dmesg2file"
                onClicked: {
                    fileDialog.open()
                }

                Button {
                    id: devices
                    x: 475
                    y: 45
                    text: "Devices"
                    onClicked: {
                        rect1.focus = true
                        textArea.text = DmesgCall.call_dev()
                        textArea.opacity = 1
                    }
                }

                Button {
                    x: 475
                    y: 82
                    id: cpuinfo
                    text: "CPUinfo"
                    onClicked: {
                        rect1.focus = true
                        textArea.text = DmesgCall.call_cpu()
                        textArea.opacity = 1
                    }
                }

                Button {
                    x: 475
                    y: 122
                    id: meminfo
                    text: "MEMinfo"
                    onClicked: {
                        rect1.focus = true
                        textArea.text = DmesgCall.call_mem()
                        textArea.opacity = 1
                    }
                }

                Button {
                    x: 475
                    y: 8
                    id: dmsgscr
                    text: "Dmesg"
                    onClicked: {
                        rect1.focus = true
                        textArea.text = DmesgCall.call("")
                        textArea.opacity = 1
                    }
                }

            }
        }


        FileDialog {
            id: fileDialog
            selectExisting: false
            selectedNameFilter: "All files (*)"
            sidebarVisible: true
            onAccepted: {
                console.log("Accepted: " + fileUrls)
                DmesgCall.call(fileUrls)
            }
            onRejected: { console.log("Rejected") }
        }

        Button {
            id: button
            x: 566
            y: 426
            width: 97
            height: 54
            text: qsTr("Exit")
            checkable: false
            z: 1
            clip: true
            style: ButtonStyle {
                background: Image {
                    fillMode: Image.PreserveAspectFit
                    source: control.pressed ? "exit.png" :
                                              (control.hovered ? "exitactiv.png" : "exit.png")
                }
            }

            onClicked: w3.show()
        }

        ListView {
            id: listView
            x: 7
            y: 72
            width: 105
            height: 160
            model: ListModel {
                ListElement {
                    name: ""
                    colorCode: "red"
                }

                ListElement {
                    name: ""
                    colorCode: "yellow"
                }

                ListElement {
                    name: ""
                    colorCode: "green"
                }

                ListElement {
                    name: ""
                    colorCode: "blue"
                }
                ListElement {
                    name: ""
                    colorCode: "orange"
                }
                ListElement {
                    name: ""
                    colorCode: "violet"
                }
            }
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                alltext.text = "X= " + mouseX + " Y=" + mouseY
                            }
                        }
                    }

                    Text {
                        id: alltext
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                    spacing: 10
                }
            }
        }

        FileDialog {
            id: fileDialog2
            selectExisting: true
            nameFilters: [ "Image files (*.png *.jpg *.jpeg)", "All files (*)" ]
            selectedNameFilter: "All files (*)"
            sidebarVisible: true
            onAccepted: {
                var path = fileDialog2.fileUrl.toString();
                image.source = Qt.resolvedUrl(path)
            }
            onRejected: { console.log("Rejected") }
        }



    }

}
