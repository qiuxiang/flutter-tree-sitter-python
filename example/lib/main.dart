import 'dart:convert';
import 'dart:ui';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/solarized-light.dart';
import 'package:flutter_tree_sitter/flutter_tree_sitter.dart' hide Stack;
import 'package:flutter_tree_sitter_python/flutter_tree_sitter_python.dart';
import 'package:flutter_tree_sitter_python/highlight.dart';

const hightlightTheme = solarizedLightTheme;
final textStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: hightlightTheme['root']?.color,
  height: 1.5,
  letterSpacing: 0,
);

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
        platform: TargetPlatform.iOS,
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
              color: hightlightTheme['root']?.backgroundColor,
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
  final parser = TreeSitterParser();
  final highlighter = Highlighter(
    treeSitterPython,
    highlightQuery: pythonHighlightQuery,
  );
  var tokens = <HighlightSpan>[];
  TreeSitterTree? tree;

  @override
  void initState() {
    super.initState();
    parser.setLanguage(treeSitterPython);
    code.text = widget.code;
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  @override
  void dispose() {
    tree?.delete();
    parser.delete();
    highlighter.delete();
    super.dispose();
  }

  void update() {
    tree?.delete();
    tree = parser.parseString(code.text);
    treeString = '';
    walk(tree!.rootNode, 0);
    widget.onChanged(treeString);
    setState(() {
      tokens = highlighter.render(
        code.text,
        highlighter.highlight(tree!.rootNode),
      );
    });
    getErrors(tree!.rootNode);
  }

  void getErrors(TSNode rootNode) {
    final codeBytes = utf8.encode(code.text);
    final query = TreeSitterQuery(treeSitterPython, '(ERROR) @error');
    for (final capture in query.captures(rootNode)) {
      final start = capture.node.startPoint;
      final position = '${start.row + 1}:${start.column + 1}';
      final errorTokens = utf8.decode(codeBytes.sublist(
        capture.node.startByte,
        capture.node.endByte,
      ));
      if (treeSitter.ts_node_is_missing(capture.node)) {
        print('$position missing $errorTokens');
      } else {
        print('$position unexpected $errorTokens');
      }
    }
    query.delete();
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
    final lines = code.text.split('\n');
    return Card(
      color: hightlightTheme['root']?.backgroundColor,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < lines.length; i += 1)
                  Text('${i + 1}', style: textStyle),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: RichText(
                    text: TextSpan(style: textStyle, children: [
                      for (final token in tokens)
                        TextSpan(
                          text: token.text,
                          style: textStyle.merge(hightlightTheme[token.type]),
                        ),
                    ]),
                  ),
                ),
                Positioned.fill(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: TextSelectionThemeData(
                        selectionColor:
                            hightlightTheme['comment']?.color?.withOpacity(0.5),
                      ),
                    ),
                    child: TextField(
                      controller: code,
                      onChanged: (_) => update(),
                      maxLines: null,
                      cursorColor: hightlightTheme['root']?.color,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 4),
                        border: InputBorder.none,
                      ),
                      style: textStyle.copyWith(color: Colors.transparent),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

const pythonCode = '''
n = int(input('Type a number, and its factorial will be printed: '))

if n < 0:
    raise ValueError('You must enter a non-negative integer')

factorial = 1
for i in range(2, n + 1):
    factorial *= i

print(factorial)''';
