// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

class NativeLibrary {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeLibrary(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeLibrary.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  ffi.Pointer<TSLanguage> tree_sitter_python() {
    return _tree_sitter_python();
  }

  late final _tree_sitter_pythonPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<TSLanguage> Function()>>(
          'tree_sitter_python');
  late final _tree_sitter_python =
      _tree_sitter_pythonPtr.asFunction<ffi.Pointer<TSLanguage> Function()>();
}

abstract class ts_symbol_identifiers {
  static const int sym_identifier = 1;
  static const int anon_sym_SEMI = 2;
  static const int anon_sym_import = 3;
  static const int anon_sym_DOT = 4;
  static const int anon_sym_from = 5;
  static const int anon_sym___future__ = 6;
  static const int anon_sym_LPAREN = 7;
  static const int anon_sym_RPAREN = 8;
  static const int anon_sym_COMMA = 9;
  static const int anon_sym_as = 10;
  static const int anon_sym_STAR = 11;
  static const int anon_sym_print = 12;
  static const int anon_sym_GT_GT = 13;
  static const int anon_sym_assert = 14;
  static const int anon_sym_COLON_EQ = 15;
  static const int anon_sym_return = 16;
  static const int anon_sym_del = 17;
  static const int anon_sym_raise = 18;
  static const int anon_sym_pass = 19;
  static const int anon_sym_break = 20;
  static const int anon_sym_continue = 21;
  static const int anon_sym_if = 22;
  static const int anon_sym_COLON = 23;
  static const int anon_sym_elif = 24;
  static const int anon_sym_else = 25;
  static const int anon_sym_match = 26;
  static const int anon_sym_case = 27;
  static const int anon_sym_async = 28;
  static const int anon_sym_for = 29;
  static const int anon_sym_in = 30;
  static const int anon_sym_while = 31;
  static const int anon_sym_try = 32;
  static const int anon_sym_except = 33;
  static const int anon_sym_except_STAR = 34;
  static const int anon_sym_finally = 35;
  static const int anon_sym_with = 36;
  static const int anon_sym_def = 37;
  static const int anon_sym_DASH_GT = 38;
  static const int anon_sym_STAR_STAR = 39;
  static const int anon_sym_global = 40;
  static const int anon_sym_nonlocal = 41;
  static const int anon_sym_exec = 42;
  static const int anon_sym_type = 43;
  static const int anon_sym_EQ = 44;
  static const int anon_sym_class = 45;
  static const int anon_sym_LBRACK = 46;
  static const int anon_sym_RBRACK = 47;
  static const int anon_sym_AT = 48;
  static const int anon_sym_DASH = 49;
  static const int anon_sym__ = 50;
  static const int anon_sym_PIPE = 51;
  static const int anon_sym_LBRACE = 52;
  static const int anon_sym_RBRACE = 53;
  static const int anon_sym_PLUS = 54;
  static const int anon_sym_not = 55;
  static const int anon_sym_and = 56;
  static const int anon_sym_or = 57;
  static const int anon_sym_SLASH = 58;
  static const int anon_sym_PERCENT = 59;
  static const int anon_sym_SLASH_SLASH = 60;
  static const int anon_sym_AMP = 61;
  static const int anon_sym_CARET = 62;
  static const int anon_sym_LT_LT = 63;
  static const int anon_sym_TILDE = 64;
  static const int anon_sym_LT = 65;
  static const int anon_sym_LT_EQ = 66;
  static const int anon_sym_EQ_EQ = 67;
  static const int anon_sym_BANG_EQ = 68;
  static const int anon_sym_GT_EQ = 69;
  static const int anon_sym_GT = 70;
  static const int anon_sym_LT_GT = 71;
  static const int anon_sym_is = 72;
  static const int anon_sym_lambda = 73;
  static const int anon_sym_PLUS_EQ = 74;
  static const int anon_sym_DASH_EQ = 75;
  static const int anon_sym_STAR_EQ = 76;
  static const int anon_sym_SLASH_EQ = 77;
  static const int anon_sym_AT_EQ = 78;
  static const int anon_sym_SLASH_SLASH_EQ = 79;
  static const int anon_sym_PERCENT_EQ = 80;
  static const int anon_sym_STAR_STAR_EQ = 81;
  static const int anon_sym_GT_GT_EQ = 82;
  static const int anon_sym_LT_LT_EQ = 83;
  static const int anon_sym_AMP_EQ = 84;
  static const int anon_sym_CARET_EQ = 85;
  static const int anon_sym_PIPE_EQ = 86;
  static const int anon_sym_yield = 87;
  static const int sym_ellipsis = 88;
  static const int sym_escape_sequence = 89;
  static const int sym__not_escape_sequence = 90;
  static const int aux_sym_format_specifier_token1 = 91;
  static const int sym_type_conversion = 92;
  static const int sym_integer = 93;
  static const int sym_float = 94;
  static const int anon_sym_await = 95;
  static const int sym_true = 96;
  static const int sym_false = 97;
  static const int sym_none = 98;
  static const int sym_comment = 99;
  static const int sym_line_continuation = 100;
  static const int sym__newline = 101;
  static const int sym__indent = 102;
  static const int sym__dedent = 103;
  static const int sym_string_start = 104;
  static const int sym__string_content = 105;
  static const int sym_escape_interpolation = 106;
  static const int sym_string_end = 107;
  static const int sym_module = 108;
  static const int sym__statement = 109;
  static const int sym__simple_statements = 110;
  static const int sym_import_statement = 111;
  static const int sym_import_prefix = 112;
  static const int sym_relative_import = 113;
  static const int sym_future_import_statement = 114;
  static const int sym_import_from_statement = 115;
  static const int sym__import_list = 116;
  static const int sym_aliased_import = 117;
  static const int sym_wildcard_import = 118;
  static const int sym_print_statement = 119;
  static const int sym_chevron = 120;
  static const int sym_assert_statement = 121;
  static const int sym_expression_statement = 122;
  static const int sym_named_expression = 123;
  static const int sym__named_expression_lhs = 124;
  static const int sym_return_statement = 125;
  static const int sym_delete_statement = 126;
  static const int sym_raise_statement = 127;
  static const int sym_pass_statement = 128;
  static const int sym_break_statement = 129;
  static const int sym_continue_statement = 130;
  static const int sym_if_statement = 131;
  static const int sym_elif_clause = 132;
  static const int sym_else_clause = 133;
  static const int sym_match_statement = 134;
  static const int sym__match_block = 135;
  static const int sym_case_clause = 136;
  static const int sym_for_statement = 137;
  static const int sym_while_statement = 138;
  static const int sym_try_statement = 139;
  static const int sym_except_clause = 140;
  static const int sym_except_group_clause = 141;
  static const int sym_finally_clause = 142;
  static const int sym_with_statement = 143;
  static const int sym_with_clause = 144;
  static const int sym_with_item = 145;
  static const int sym_function_definition = 146;
  static const int sym_parameters = 147;
  static const int sym_lambda_parameters = 148;
  static const int sym_list_splat = 149;
  static const int sym_dictionary_splat = 150;
  static const int sym_global_statement = 151;
  static const int sym_nonlocal_statement = 152;
  static const int sym_exec_statement = 153;
  static const int sym_type_alias_statement = 154;
  static const int sym_class_definition = 155;
  static const int sym_type_parameter = 156;
  static const int sym_parenthesized_list_splat = 157;
  static const int sym_argument_list = 158;
  static const int sym_decorated_definition = 159;
  static const int sym_decorator = 160;
  static const int sym_block = 161;
  static const int sym_expression_list = 162;
  static const int sym_dotted_name = 163;
  static const int sym_case_pattern = 164;
  static const int sym__simple_pattern = 165;
  static const int sym__as_pattern = 166;
  static const int sym_union_pattern = 167;
  static const int sym__list_pattern = 168;
  static const int sym__tuple_pattern = 169;
  static const int sym_dict_pattern = 170;
  static const int sym__key_value_pattern = 171;
  static const int sym_keyword_pattern = 172;
  static const int sym_splat_pattern = 173;
  static const int sym_class_pattern = 174;
  static const int sym_complex_pattern = 175;
  static const int sym__parameters = 176;
  static const int sym__patterns = 177;
  static const int sym_parameter = 178;
  static const int sym_pattern = 179;
  static const int sym_tuple_pattern = 180;
  static const int sym_list_pattern = 181;
  static const int sym_default_parameter = 182;
  static const int sym_typed_default_parameter = 183;
  static const int sym_list_splat_pattern = 184;
  static const int sym_dictionary_splat_pattern = 185;
  static const int sym_as_pattern = 186;
  static const int sym__expression_within_for_in_clause = 187;
  static const int sym_expression = 188;
  static const int sym_primary_expression = 189;
  static const int sym_not_operator = 190;
  static const int sym_boolean_operator = 191;
  static const int sym_binary_operator = 192;
  static const int sym_unary_operator = 193;
  static const int sym_comparison_operator = 194;
  static const int sym_lambda = 195;
  static const int sym_lambda_within_for_in_clause = 196;
  static const int sym_assignment = 197;
  static const int sym_augmented_assignment = 198;
  static const int sym_pattern_list = 199;
  static const int sym__right_hand_side = 200;
  static const int sym_yield = 201;
  static const int sym_attribute = 202;
  static const int sym_subscript = 203;
  static const int sym_slice = 204;
  static const int sym_call = 205;
  static const int sym_typed_parameter = 206;
  static const int sym_type = 207;
  static const int sym_splat_type = 208;
  static const int sym_generic_type = 209;
  static const int sym_union_type = 210;
  static const int sym_constrained_type = 211;
  static const int sym_member_type = 212;
  static const int sym_keyword_argument = 213;
  static const int sym_list = 214;
  static const int sym_set = 215;
  static const int sym_tuple = 216;
  static const int sym_dictionary = 217;
  static const int sym_pair = 218;
  static const int sym_list_comprehension = 219;
  static const int sym_dictionary_comprehension = 220;
  static const int sym_set_comprehension = 221;
  static const int sym_generator_expression = 222;
  static const int sym__comprehension_clauses = 223;
  static const int sym_parenthesized_expression = 224;
  static const int sym__collection_elements = 225;
  static const int sym_for_in_clause = 226;
  static const int sym_if_clause = 227;
  static const int sym_conditional_expression = 228;
  static const int sym_concatenated_string = 229;
  static const int sym_string = 230;
  static const int sym_string_content = 231;
  static const int sym_interpolation = 232;
  static const int sym__f_expression = 233;
  static const int sym_format_specifier = 234;
  static const int sym_await = 235;
  static const int sym_positional_separator = 236;
  static const int sym_keyword_separator = 237;
  static const int aux_sym_module_repeat1 = 238;
  static const int aux_sym__simple_statements_repeat1 = 239;
  static const int aux_sym_import_prefix_repeat1 = 240;
  static const int aux_sym__import_list_repeat1 = 241;
  static const int aux_sym_print_statement_repeat1 = 242;
  static const int aux_sym_assert_statement_repeat1 = 243;
  static const int aux_sym_if_statement_repeat1 = 244;
  static const int aux_sym_match_statement_repeat1 = 245;
  static const int aux_sym__match_block_repeat1 = 246;
  static const int aux_sym_case_clause_repeat1 = 247;
  static const int aux_sym_try_statement_repeat1 = 248;
  static const int aux_sym_try_statement_repeat2 = 249;
  static const int aux_sym_with_clause_repeat1 = 250;
  static const int aux_sym_global_statement_repeat1 = 251;
  static const int aux_sym_type_parameter_repeat1 = 252;
  static const int aux_sym_argument_list_repeat1 = 253;
  static const int aux_sym_decorated_definition_repeat1 = 254;
  static const int aux_sym_dotted_name_repeat1 = 255;
  static const int aux_sym_union_pattern_repeat1 = 256;
  static const int aux_sym_dict_pattern_repeat1 = 257;
  static const int aux_sym__parameters_repeat1 = 258;
  static const int aux_sym__patterns_repeat1 = 259;
  static const int aux_sym_comparison_operator_repeat1 = 260;
  static const int aux_sym_subscript_repeat1 = 261;
  static const int aux_sym_dictionary_repeat1 = 262;
  static const int aux_sym__comprehension_clauses_repeat1 = 263;
  static const int aux_sym__collection_elements_repeat1 = 264;
  static const int aux_sym_for_in_clause_repeat1 = 265;
  static const int aux_sym_concatenated_string_repeat1 = 266;
  static const int aux_sym_string_repeat1 = 267;
  static const int aux_sym_string_content_repeat1 = 268;
  static const int aux_sym_format_specifier_repeat1 = 269;
  static const int alias_sym_as_pattern_target = 270;
  static const int alias_sym_format_expression = 271;
  static const int anon_alias_sym_isnot = 272;
  static const int anon_alias_sym_notin = 273;
}

abstract class ts_field_identifiers {
  static const int field_alias = 1;
  static const int field_alternative = 2;
  static const int field_argument = 3;
  static const int field_arguments = 4;
  static const int field_attribute = 5;
  static const int field_body = 6;
  static const int field_cause = 7;
  static const int field_code = 8;
  static const int field_condition = 9;
  static const int field_consequence = 10;
  static const int field_definition = 11;
  static const int field_expression = 12;
  static const int field_format_specifier = 13;
  static const int field_function = 14;
  static const int field_guard = 15;
  static const int field_key = 16;
  static const int field_left = 17;
  static const int field_module_name = 18;
  static const int field_name = 19;
  static const int field_object = 20;
  static const int field_operator = 21;
  static const int field_operators = 22;
  static const int field_parameters = 23;
  static const int field_return_type = 24;
  static const int field_right = 25;
  static const int field_subject = 26;
  static const int field_subscript = 27;
  static const int field_superclasses = 28;
  static const int field_type = 29;
  static const int field_type_conversion = 30;
  static const int field_type_parameters = 31;
  static const int field_value = 32;
}

abstract class ts_external_scanner_symbol_identifiers {
  static const int ts_external_token__newline = 0;
  static const int ts_external_token__indent = 1;
  static const int ts_external_token__dedent = 2;
  static const int ts_external_token_string_start = 3;
  static const int ts_external_token__string_content = 4;
  static const int ts_external_token_escape_interpolation = 5;
  static const int ts_external_token_string_end = 6;
  static const int ts_external_token_comment = 7;
  static const int ts_external_token_RBRACK = 8;
  static const int ts_external_token_RPAREN = 9;
  static const int ts_external_token_RBRACE = 10;
  static const int ts_external_token_except = 11;
}

final class TSLanguage extends ffi.Struct {
  @ffi.Uint32()
  external int version;

  @ffi.Uint32()
  external int symbol_count;

  @ffi.Uint32()
  external int alias_count;

  @ffi.Uint32()
  external int token_count;

  @ffi.Uint32()
  external int external_token_count;

  @ffi.Uint32()
  external int state_count;

  @ffi.Uint32()
  external int large_state_count;

  @ffi.Uint32()
  external int production_id_count;

  @ffi.Uint32()
  external int field_count;

  @ffi.Uint16()
  external int max_alias_sequence_length;

  external ffi.Pointer<ffi.Uint16> parse_table;

  external ffi.Pointer<ffi.Uint16> small_parse_table;

  external ffi.Pointer<ffi.Uint32> small_parse_table_map;

  external ffi.Pointer<TSParseActionEntry> parse_actions;

  external ffi.Pointer<ffi.Pointer<ffi.Char>> symbol_names;

  external ffi.Pointer<ffi.Pointer<ffi.Char>> field_names;

  external ffi.Pointer<TSFieldMapSlice> field_map_slices;

  external ffi.Pointer<TSFieldMapEntry> field_map_entries;

  external ffi.Pointer<TSSymbolMetadata> symbol_metadata;

  external ffi.Pointer<ffi.Uint16> public_symbol_map;

  external ffi.Pointer<ffi.Uint16> alias_map;

  external ffi.Pointer<ffi.Uint16> alias_sequences;

  external ffi.Pointer<TSLexMode> lex_modes;

  external ffi.Pointer<
          ffi
          .NativeFunction<ffi.Bool Function(ffi.Pointer<TSLexer>, ffi.Uint16)>>
      lex_fn;

  external ffi.Pointer<
          ffi
          .NativeFunction<ffi.Bool Function(ffi.Pointer<TSLexer>, ffi.Uint16)>>
      keyword_lex_fn;

  @ffi.Uint16()
  external int keyword_capture_token;

  external UnnamedStruct4 external_scanner;

  external ffi.Pointer<ffi.Uint16> primary_state_ids;
}

final class TSParseActionEntry extends ffi.Union {
  external TSParseAction action;

  external UnnamedStruct3 entry;
}

final class TSParseAction extends ffi.Union {
  external UnnamedStruct1 shift;

  external UnnamedStruct2 reduce;

  @ffi.Uint8()
  external int type;
}

final class UnnamedStruct1 extends ffi.Struct {
  @ffi.Uint8()
  external int type;

  @ffi.Uint16()
  external int state;

  @ffi.Bool()
  external bool extra;

  @ffi.Bool()
  external bool repetition;
}

final class UnnamedStruct2 extends ffi.Struct {
  @ffi.Uint8()
  external int type;

  @ffi.Uint8()
  external int child_count;

  @ffi.Uint16()
  external int symbol;

  @ffi.Int16()
  external int dynamic_precedence;

  @ffi.Uint16()
  external int production_id;
}

final class UnnamedStruct3 extends ffi.Struct {
  @ffi.Uint8()
  external int count;

  @ffi.Bool()
  external bool reusable;
}

final class TSFieldMapSlice extends ffi.Struct {
  @ffi.Uint16()
  external int index;

  @ffi.Uint16()
  external int length;
}

final class TSFieldMapEntry extends ffi.Struct {
  @ffi.Uint16()
  external int field_id;

  @ffi.Uint8()
  external int child_index;

  @ffi.Bool()
  external bool inherited;
}

final class TSSymbolMetadata extends ffi.Struct {
  @ffi.Bool()
  external bool visible;

  @ffi.Bool()
  external bool named;

  @ffi.Bool()
  external bool supertype;
}

final class TSLexMode extends ffi.Struct {
  @ffi.Uint16()
  external int lex_state;

  @ffi.Uint16()
  external int external_lex_state;
}

final class TSLexer extends ffi.Struct {
  @ffi.Int32()
  external int lookahead;

  @ffi.Uint16()
  external int result_symbol;

  external ffi.Pointer<
          ffi.NativeFunction<ffi.Void Function(ffi.Pointer<TSLexer>, ffi.Bool)>>
      advance;

  external ffi
      .Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<TSLexer>)>>
      mark_end;

  external ffi
      .Pointer<ffi.NativeFunction<ffi.Uint32 Function(ffi.Pointer<TSLexer>)>>
      get_column;

  external ffi
      .Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<TSLexer>)>>
      is_at_included_range_start;

  external ffi
      .Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<TSLexer>)>> eof;
}

final class UnnamedStruct4 extends ffi.Struct {
  external ffi.Pointer<ffi.Bool> states;

  external ffi.Pointer<ffi.Uint16> symbol_map;

  external ffi.Pointer<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>
      create;

  external ffi
      .Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
      destroy;

  external ffi.Pointer<
      ffi.NativeFunction<
          ffi.Bool Function(ffi.Pointer<ffi.Void>, ffi.Pointer<TSLexer>,
              ffi.Pointer<ffi.Bool>)>> scan;

  external ffi.Pointer<
      ffi.NativeFunction<
          ffi.UnsignedInt Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>> serialize;

  external ffi.Pointer<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>,
              ffi.UnsignedInt)>> deserialize;
}
