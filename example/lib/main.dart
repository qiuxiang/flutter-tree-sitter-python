import 'dart:ffi';
import 'dart:ui';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree_sitter/bindings.g.dart';
import 'package:flutter_tree_sitter/flutter_tree_sitter.dart';
import 'package:flutter_tree_sitter_python/flutter_tree_sitter_python.dart';

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
  final language = treeSitterPython.tree_sitter_python() as Pointer<TSLanguage>;
  final highlightList = <(int, int), String>{};

  @override
  void initState() {
    super.initState();
    final parser = treeSitter.ts_parser_new();
    treeSitter.ts_parser_set_language(parser, language);
    final codePtr = pythonCode.toNativeUtf8().cast<Char>();
    final tree = treeSitter.ts_parser_parse_string(
      parser,
      nullptr,
      codePtr,
      pythonCode.length,
    );
    free(codePtr);
    final rootNode = treeSitter.ts_tree_root_node(tree);
    setState(() {
      walkTree(rootNode, 0);
    });
    queryHighlight(rootNode);
    treeSitter.ts_tree_delete(tree);
    treeSitter.ts_parser_delete(parser);
  }

  void queryHighlight(TSNode rootNode) {
    const querySource = highlightQuery;
    final querySourcePtr = querySource.toNativeUtf8().cast<Char>();
    final queryErrorOffset = malloc<Uint32>();
    final queryErrorType = malloc<UnsignedInt>();
    final query = treeSitter.ts_query_new(
      language,
      querySourcePtr,
      querySource.length,
      queryErrorOffset,
      queryErrorType,
    );
    print(query.ref.pattern_map.size);
    final queryCursor = treeSitter.ts_query_cursor_new();
    treeSitter.ts_query_cursor_exec(queryCursor, query, rootNode);
    final match = malloc<TSQueryMatch>();
    while (treeSitter.ts_query_cursor_next_match(queryCursor, match)) {
      for (var i = 0; i < match.ref.capture_count; i += 1) {
        final item = match.ref.captures[i];
        final start = treeSitter.ts_node_start_byte(item.node);
        final end = treeSitter.ts_node_end_byte(item.node);
        final nameLength = malloc<Uint32>();
        final name = treeSitter
            .ts_query_capture_name_for_id(query, item.index, nameLength)
            .cast<Utf8>()
            .toDartString(length: nameLength.value);
        final position = (start, end);
        if (!highlightList.containsKey(position)) {
          print('$position, $name:${pythonCode.substring(start, end)}');
          highlightList[position] = name;
        }
      }
      treeSitter.ts_query_cursor_remove_match(queryCursor, match.ref.id);
    }
    free(match);
    free(querySourcePtr);
    free(queryErrorOffset);
    free(queryErrorType);
    treeSitter.ts_query_cursor_delete(queryCursor);
    treeSitter.ts_query_delete(query);
  }

  void walkTree(TSNode node, int level) {
    final count = treeSitter.ts_node_named_child_count(node);
    if (count > 0) {
      final typeString = treeSitter.ts_node_type(node);
      treeString +=
          '${'  ' * level}${typeString.cast<Utf8>().toDartString()}\n';
      for (var i = 0; i < count; i += 1) {
        walkTree(treeSitter.ts_node_named_child(node, i), level + 1);
      }
    } else {
      final typeString = treeSitter.ts_node_type(node);
      treeString +=
          '${'  ' * level}${typeString.cast<Utf8>().toDartString()}\n';
    }
  }

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
            CodeBlock(pythonCode, highlightList: highlightList),
            const SizedBox(height: 16),
            const Text('AST:'),
            const SizedBox(height: 4),
            CodeBlock(treeString),
          ],
        ),
      ),
    );
  }
}

class CodeBlock extends StatelessWidget {
  final String code;
  final Map<(int, int), String> highlightList;
  const CodeBlock(this.code, {super.key, this.highlightList = const {}});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 12,
      color: Colors.black87,
      height: 1.5,
    );
    final lines = code.split('\n');
    final highlightIter = highlightList.keys.iterator;
    var hasHighlight = highlightIter.moveNext();
    var lineStart = 0;
    return Card(
      margin: EdgeInsets.zero,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < lines.length; index += 1) ...[
              Builder(builder: (context) {
                final texts = <TextSpan>[];
                final line = lines[index];
                var text = '';
                for (var i = 0; i < line.length; i += 1) {
                  final highlight = hasHighlight ? highlightIter.current : null;
                  if (highlight != null && highlight.$1 == lineStart + i) {
                    if (text.isNotEmpty) {
                      texts.add(TextSpan(text: text, style: textStyle));
                    }
                    final highlightName = highlightList[highlight];
                    texts.add(TextSpan(
                      text: line.substring(i, highlight.$2 - lineStart),
                      style: textStyle.merge(
                        solarizedLightTheme[highlightName] ??
                            const TextStyle(color: Color(0xff657b83)),
                      ),
                    ));
                    i += highlight.$2 - highlight.$1 - 1;
                    hasHighlight = highlightIter.moveNext();
                    text = '';
                  } else {
                    text += line[i];
                  }
                }
                texts.add(TextSpan(text: text, style: textStyle));
                lineStart += line.length + 1;
                return RichText(
                  text: TextSpan(style: textStyle, children: texts),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}

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

const highlightQuery = '''
; Identifier naming conventions

(identifier) @variable

((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z_]*\$"))

; Function calls

(decorator) @function

(call
  function: (attribute attribute: (identifier) @function.method))
(call
  function: (identifier) @function)

; Builtin functions

((call
  function: (identifier) @function.builtin)
 (#match?
   @function.builtin
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)\$"))

; Function definitions

(function_definition
  name: (identifier) @function)

(attribute attribute: (identifier) @property)
(type (identifier) @type)

; Literals

[
  (none)
  (true)
  (false)
] @constant.builtin

[
  (integer)
  (float)
] @number

(comment) @comment
(string) @string
(escape_sequence) @escape

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded

[
  "-"
  "-="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "&"
  "&="
  "%"
  "%="
  "^"
  "^="
  "+"
  "->"
  "+="
  "<"
  "<<"
  "<<="
  "<="
  "<>"
  "="
  ":="
  "=="
  ">"
  ">="
  ">>"
  ">>="
  "|"
  "|="
  "~"
  "@="
  "and"
  "in"
  "is"
  "not"
  "or"
] @operator

[
  "as"
  "assert"
  "async"
  "await"
  "break"
  "class"
  "continue"
  "def"
  "del"
  "elif"
  "else"
  "except"
  "exec"
  "finally"
  "for"
  "from"
  "global"
  "if"
  "import"
  "lambda"
  "nonlocal"
  "pass"
  "print"
  "raise"
  "return"
  "try"
  "while"
  "with"
  "yield"
  "match"
  "case"
] @keyword
''';
