/*
  Q Light Controller Plus
  WidgetsList.qml

  Copyright (c) Massimo Callegari

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0.txt

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import QtQuick 2.0

Rectangle
{
    id: widgetsContainer
    anchors.fill: parent
    color: "transparent"

    ListModel
    {
        id: wModel
        ListElement { name: qsTr("Button"); type: "Button"; icon: "button" }
        ListElement { name: qsTr("Button Matrix"); type: "buttonmatrix"; icon: "buttonmatrix" }
        ListElement { name: qsTr("Slider"); type: "Slider"; icon: "slider" }
        ListElement { name: qsTr("Slider Matrix"); type: "slidermatrix"; icon: "sliders" }
        ListElement { name: qsTr("Knob"); type: "Knob"; icon: "knob" }
        ListElement { name: qsTr("Speed Dial"); type: "Speed dial"; icon: "speed" }
        ListElement { name: qsTr("XY Pad"); type: "XYPad"; icon: "xypad" }
        ListElement { name: qsTr("Cue List"); type: "Cue list"; icon: "cuelist" }
        ListElement { name: qsTr("Animation"); type: "Animation"; icon: "animation" }
        ListElement { name: qsTr("Frame"); type: "Frame"; icon: "frame" }
        ListElement { name: qsTr("Solo Frame"); type: "Solo frame"; icon: "soloframe" }
        ListElement { name: qsTr("Label"); type: "Label"; icon: "label" }
        ListElement { name: qsTr("Audio Triggers"); type: "Audio Triggers"; icon: "audiotriggers" }
        ListElement { name: qsTr("Clock"); type: "clock"; icon: "clock" }
    }

    ListView
    {
        id: uniListView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        model: wModel
        delegate:
            Item
            {
                id: root
                height: 60
                width: widgetsContainer.width

                MouseArea
                {
                    id: delegateRoot
                    width: widgetsContainer.width
                    height: 60

                    drag.target: widgetItem
                    drag.threshold: 30

                    onPressed:
                    {
                        //widgetItem.color = "#444"
                        widgetItem.reduced = true
                        widgetItem.x = mouse.x
                    }
                    onReleased:
                    {
                        if (widgetItem.Drag.target !== null)
                        {
                            // create the widget here
                            //console.log("Item dropped on " + widgetItem.Drag.target)
                            widgetItem.Drag.drop()
                        }
                        else
                        {
                            // return the dragged item to its original position
                            parent = root
                        }
                        widgetItem.x = 3
                        widgetItem.y = 0
                        widgetItem.reduced = false
                        //widgetItem.color = "transparent"
                    }
                    WidgetDragItem
                    {
                        id: widgetItem
                        x: 3

                        widgetName: name
                        widgetType: type
                        widgetIconName: icon

                        Drag.active: delegateRoot.drag.active
                        Drag.source: widgetItem
                        Drag.hotSpot.x: 30
                        Drag.hotSpot.y: 30
                        Drag.keys: [ "vcwidget" ]

                        // line divider
                        Rectangle
                        {
                            width: parent.width - 6
                            height: 1
                            y: parent.height - 1
                            color: "#555"
                            visible: widgetItem.reduced ? false : true
                        }
                    } // PluginDragItem
                } // MouseArea
            } // Item
    } // ListView
}

