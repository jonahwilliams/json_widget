## json_widget

Generate widgets from JSON. This is only a simple demonstration of how to write code generation in Dart. To use in a flutter project, add to the builders section of the pubspec.yaml.


```
name: example

...

builders:
    json_widget: any

```

Then you can generate Widgets from JSON blobs (Silly, I know) during a flutter run. For example:


example.json
```
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

```

Then import this example file into your main and `flutter run`. There may be an analyzer warning that `example.dart` (NB: example.json) doesn't exist.


main.dart
```
import 'package:flutter/material.dart';
import 'example.dart' as generated; // May not exist, it is okay!

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView(
          children: [
            // use our generated widget
            generated.GeneratedWidget(),
          ]
        ),
      ),
    );
  }
}

```