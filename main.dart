// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(TestScreen());

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List sections = [1,0,0];
  bool firstLoad = true;
  int selectedIndex;
  var reading;
  List choices;
  String goto;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: _getReadingAndChoices(),
        ),
      ),
    );
  }

  Map storyData = {
    "playerCharacter": {
      "name": "Jim",
      "charisma": 5
    },
    "people": [
      {"name": "billy"},
      {"name": "Joe"}
    ],
    "Chapter 1": {
      "d-0": {
        "0": {
          "reading": [
            "There {people[1].name} was something so important to read here {name}",
            ""
          ],
          "choices": [
            {
              "decision": "Take the money and run",
              "reading": "You fall down",
              "goto": [1, 1]
            },
            {
              "decision": "Walk away poor",
              "goto": [1, 2]
            }
          ]
        }
      },
      "d-1": {
        "1": {
          "reading": [
            "You start to run and trip because you didn't tie your shoes"
          ],
          "choices": [
            {
              "decision": "Take the money and run",
              "goto": [2, 1]
            }
          ]
        },
        "2": {"reading": "You spend the rest of your life poor with {charisma}"}
      },
      "d-2": {
        "1-1A": {
          "reading": [
            "You start to run and trip because you didn't tie your shoes"
          ],
          "choices": [
            {"decision": "Take the money and run", "goto": "1-1A-2A"}
          ]
        },
        "1-1B": {
          "reading": "You spend the rest of your life poor with {charisma}"
        }
      }
    }
  };

  String _findVariables(String str) {
    final startIndex = str.indexOf('{');
    final endIndex = str.indexOf('}', startIndex + 1);

    if (startIndex != -1 && endIndex != -1) {
      String attributeKey = str.substring(startIndex + 1, endIndex);
      String attribute = storyData['stats'][attributeKey];
      return str.replaceAll('{$attributeKey}', attribute);
    }
    return str;
  }

  Widget _getReadingAndChoices() {
    var testing = storyData[sections[0]][sections[1]][sections[2]];
    if (testing !=null) {
      return Text('Testing is: $testing');
    }
    else {
      return Text('Nothing could be found');
    }
  }
}