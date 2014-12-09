import QtQuick 2.3

PrimaryButton {
    id: dropDown;
    text: "Default";

    property string dropdownColor: "#f3f4f5";
    property string highlightColor: "#dee1e2";
    property string dropdownTextColor: "#606d7a";
    property int dropdownItemHeight: 40;
    property int dropdownWidth: 250;
    property int dropdownRadius: 4;

    property var model: ListModel {
        ListElement {item: "Apple";}
        ListElement {item: "Orange"; separator: true}
        ListElement {item: "Kiwi"; separator: true}
        ListElement {item: "Squash"; separator: true}
        ListElement {item: "Tree Bark"; separator: true}
        ListElement {item: "Llama"; separator: true}
    }

    Component.onCompleted: parent.z = 100;

    Rectangle {
        id: dropdownBackground;
        z: 100;
        radius: dropDown.dropdownRadius;
        visible: dropDown.mouseField.clickedButton;
        x: parent.x;
        height: dropDown.dropdownItemHeight * listView.count;
        width: dropDown.dropdownWidth;
        color: dropDown.dropdownColor;
        anchors {
            top: dropDown.bottom;
            topMargin: 10;
        }
        ListView {
            id: listView;
            anchors.fill: parent;
            highlightFollowsCurrentItem: true;
            highlight: Rectangle {
                width: listView.currentItem.width;
                height: listView.currentItem.height;
                color: dropDown.highlightColor;
                radius: (listView.currentIndex !== listView.count-1 && listView.currentIndex !== 0) ? 0 : dropDown.dropdownRadius;
            }

            model: dropDown.model;
            delegate: Item {
                width: listView.width;
                height: dropDown.dropdownItemHeight;
                Rectangle {
                    id: separation;
                    color: dropDown.highlightColor;
                    height: 2;
                    visible: separator;
                    anchors {
                        top: parent.top;
                        left: parent.left;
                        right: parent.right;
                    }
                }

                Item {
                    anchors {
                        top: separation.bottom;
                        left: parent.left;
                        right: parent.right;
                        bottom: parent.bottom;
                    }

                    MouseArea {
                        anchors.fill: parent;
                        hoverEnabled: true;
                        onEntered: {
                            listView.currentIndex = index;
                        }
                    }
                    Text {
                        text: item;
                        color: dropDown.dropdownTextColor;
                        anchors {
                            left: parent.left;
                            leftMargin: 12;
                            verticalCenter: parent.verticalCenter;
                        }
                        font {
                            pointSize: 10;
                        }
                    }
                }
            }
        }
    }


}