import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree_sitter/bindings.g.dart';
import 'package:flutter_tree_sitter/flutter_tree_sitter.dart';
import 'package:flutter_tree_sitter_python/flutter_tree_sitter_python.dart';

const pythonCode = '''
n = int(input('Type a number, and its factorial will be printed: '))

if n < 0:
    raise ValueError('You must enter a non-negative integer')

factorial = 1
for i in range(2, n + 1):
    factorial *= i

print(factorial)''';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var treeString = '';

  @override
  void initState() {
    super.initState();
    final parser = treeSitter.ts_parser_new();
    treeSitter.ts_parser_set_language(
      parser,
      treeSitterPython.tree_sitter_python() as Pointer<TSLanguage>,
    );
    final code = pythonCode.toNativeUtf8().cast<Char>();
    final tree = treeSitter.ts_parser_parse_string(
      parser,
      nullptr,
      code,
      pythonCode.length,
    );
    malloc.free(code);
    final rootNode = treeSitter.ts_tree_root_node(tree);
    final nodeString = treeSitter.ts_node_string(rootNode);
    setState(() {
      treeString = nodeString.cast<Utf8>().toDartString();
    });
    treeSitter.free(nodeString as Pointer<Void>);
    treeSitter.ts_tree_delete(tree);
    treeSitter.ts_parser_delete(parser);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Source:'),
              const SizedBox(height: 4),
              const CodeBlock(pythonCode),
              const SizedBox(height: 16),
              const Text('S-Expression:'),
              const SizedBox(height: 4),
              CodeBlock(treeString),
            ],
          ),
        ),
      ),
    );
  }
}

class CodeBlock extends StatelessWidget {
  final String code;
  const CodeBlock(this.code, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          code,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
      ),
    );
  }
}
