import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/solarized-light.dart';
import 'package:flutter_tree_sitter_editor/flutter_tree_sitter_editor.dart';
import 'package:flutter_tree_sitter_python/flutter_tree_sitter_python.dart';
import 'package:flutter_tree_sitter_python/highlight.dart';

final analyzer = TreeSitterAnalyzer(treeSitterPython);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        backgroundColor: solarizedLightTheme['root']?.backgroundColor,
        body: ListView(children: [
          CodeEditor(
            initialCode: code,
            analyzer: analyzer,
            language: treeSitterPython,
            highlightQuery: pythonHighlightQuery,
            theme: solarizedLightTheme,
          ),
        ]),
      ),
    );
  }
}

const code = '''
n = int(input('Type a number, and its factorial will be printed: '))

if n < 0:
    raise ValueError('You must enter a non-negative integer')

factorial = 1
for i in range(2, n + 1):
    factorial *= i

print(factorial)''';
