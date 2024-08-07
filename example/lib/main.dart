import 'dart:ffi';
import 'dart:ui';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree_sitter/bindings.g.dart' hide Stack;
import 'package:flutter_tree_sitter/flutter_tree_sitter.dart';
import 'package:flutter_tree_sitter_python/flutter_tree_sitter_python.dart';
import 'package:flutter_tree_sitter_python/highlight.dart';

void main() {
  runApp(const App());
}

class ScrollBehavior extends MaterialScrollBehavior {
  const ScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var treeString = '';

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light();
    return MaterialApp(
      scrollBehavior: const ScrollBehavior(),
      theme: theme.copyWith(
        scrollbarTheme: theme.scrollbarTheme.copyWith(
          thumbVisibility: const WidgetStatePropertyAll(true),
        ),
      ),
      home: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Source:'),
            const SizedBox(height: 4),
            CodeBlock(pythonCode, (treeString) {
              setState(() {
                this.treeString = treeString;
              });
            }),
            const SizedBox(height: 16),
            const Text('AST:'),
            const SizedBox(height: 4),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(treeString, style: textStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeBlock extends StatefulWidget {
  final String code;
  final ValueChanged<String> onChanged;
  const CodeBlock(this.code, this.onChanged, {super.key});

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  var treeString = '';
  final code = TextEditingController();
  final parser = treeSitter.ts_parser_new();
  var tokens = <List<HighlightSpan>>[];
  Pointer<TSTree>? tree;

  @override
  void initState() {
    super.initState();
    treeSitter.ts_parser_set_language(parser, language);
    code.text = widget.code;
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  @override
  void dispose() {
    if (tree != null) {
      treeSitter.ts_tree_delete(tree!);
    }
    treeSitter.ts_parser_delete(parser);
    super.dispose();
  }

  void update() {
    if (tree != null) {
      treeSitter.ts_tree_delete(tree!);
    }

    final codeBuf = code.text.toNativeUtf8().cast<Char>();
    tree = treeSitter.ts_parser_parse_string(
      parser,
      nullptr,
      codeBuf,
      code.text.length,
    );
    malloc.free(codeBuf);

    final rootNode = treeSitter.ts_tree_root_node(tree!);
    treeString = '';
    walk(rootNode, 0);
    widget.onChanged(treeString);

    final highlighter = Highlighter(
      language,
      highlightQuery: pythonHighlightQuery,
    );
    setState(() {
      tokens = highlighter.render(code.text, highlighter.highlight(rootNode));
    });
    highlighter.delete();
  }

  void walk(TSNode node, int level) {
    final count = treeSitter.ts_node_named_child_count(node);
    if (count > 0) {
      final typeString = treeSitter.ts_node_type(node);
      treeString +=
          '${'  ' * level}${typeString.cast<Utf8>().toDartString()}\n';
      for (var i = 0; i < count; i += 1) {
        walk(treeSitter.ts_node_named_child(node, i), level + 1);
      }
    } else {
      final typeString = treeSitter.ts_node_type(node);
      treeString +=
          '${'  ' * level}${typeString.cast<Utf8>().toDartString()}\n';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final line in tokens)
                  RichText(
                    text: TextSpan(style: textStyle, children: [
                      for (final span in line)
                        TextSpan(
                          text: span.text,
                          style:
                              textStyle.merge(solarizedLightTheme[span.type]),
                        ),
                    ]),
                  )
              ],
            ),
          ),
          Positioned.fill(
            child: TextField(
              controller: code,
              onChanged: (_) => update(),
              maxLines: null,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 4),
                border: InputBorder.none,
              ),
              style: textStyle.copyWith(color: Colors.transparent),
            ),
          ),
        ]),
      ),
    );
  }
}

final language = treeSitterPython.tree_sitter_python() as Pointer<TSLanguage>;
const textStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: Color(0xff657b83),
  height: 1.5,
  letterSpacing: 0,
);

const solarizedLightTheme = {
  'comment': TextStyle(color: Color(0xff93a1a1)),
  'keyword': TextStyle(color: Color(0xff859900)),
  'number': TextStyle(color: Color(0xff2aa198)),
  'string': TextStyle(color: Color(0xff2aa198)),
  'function': TextStyle(color: Color(0xff268bd2)),
  'variable': TextStyle(color: Color(0xffb58900)),
};

const pythonCode = '''
n = int(input('Type a number, and its factorial will be printed: '))

if n < 0:
    raise ValueError('You must enter a non-negative integer')

factorial = 1
for i in range(2, n + 1):
    factorial *= i

print(factorial)''';
