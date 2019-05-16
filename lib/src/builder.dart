import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';

class JsonWidgetBuilder implements Builder {
  const JsonWidgetBuilder();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    /// Read the input source and parse it as JSON.
    Map<String, Object> source;
    final AssetId outputId = buildStep.inputId.changeExtension('.dart');
    try {
      source = json.decode(await buildStep.readAsString(buildStep.inputId));
    } catch (err) {
      source = {
        "name": "Text",
        "params": {
          "0": "Error: invalid json",
        },
      };
    }
    final StringBuffer output = StringBuffer();
    // write the header.
    output.write(r'''
    import 'package:flutter/widgets.dart';

    class GeneratedWidget extends StatelessWidget {

      @override
      Widget build(BuildContext context) {
        return
''');
    WidgetGenerator().visitWidget(source, output);

    // write the footer.
    output.write(r'''
      ;}
    }
''');

    // Write the results to disk and format it.
    String outputString;
    // Always output something to keep hot reload working.
    try {
      outputString = DartFormatter().format(output.toString()).toString();
    } catch (err) {
      outputString = 'Text("json_widget error formatting")';
    }
    await buildStep.writeAsString(outputId, outputString);
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
    '.json': ['.dart']
  };
}


class WidgetGenerator {
  const WidgetGenerator();

  void visitWidget(Map<String, Object> body, StringBuffer buffer) {
    final String name = body['name'];
    final Map<String, Object> params = body['params'];
    buffer.write("$name(");
    for (String key in params.keys) {
      if (int.tryParse(key) == null) {
        buffer.write("$key: ");
      }
      visitParameter(params[key], buffer);
      buffer.write(',');
    }
    buffer.write(")");
  }

  void visitParameter(Object parameter, StringBuffer buffer) {
    if (parameter is bool) {
      buffer.write(parameter);
    } else if (parameter is String) {
      if (parameter[0] == "#") {
        buffer.write(parameter.substring(1));
      } else {
        buffer.write('"${parameter}"');
      }
    } else if (parameter is num) {
      buffer.write(parameter);
    } else if (parameter is List<Object>) {
      buffer.write('[');
      for (Object item in parameter) {
        visitParameter(item, buffer);
        buffer.write(',');
      }
      buffer.write(']');
    } else if (parameter is Map<Object, Object>) {
      visitWidget(parameter, buffer);
    }
  }
}
