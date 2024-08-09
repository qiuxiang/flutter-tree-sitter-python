import 'dart:ffi';

import 'package:flutter_tree_sitter/flutter_tree_sitter.dart';

import 'src/lib.dart';

final treeSitterPython = lib.tree_sitter_python() as Pointer<TSLanguage>;
