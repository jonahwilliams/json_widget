// Copyright 2019 Jonah Williams. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:json_widget/src/builder.dart';
import 'package:test/test.dart';

const example = '''
{
    "name": "Container",
    "params": {
        "color": "#Color(0xFF22DD11)",
        "child": {
            "name": "Text",
            "params": {
                "0": "Hello, World"
            }
        }
    }
}
''';

void main() {

  test('can generate widgets', () {
    var generator = WidgetGenerator();
    var buffer = StringBuffer();
    generator.visitWidget(json.decode(example), buffer);

    expect(buffer.toString(), 'Container(color: Color(0xFF22DD11),child: Text("Hello, World",),)');
  });
}