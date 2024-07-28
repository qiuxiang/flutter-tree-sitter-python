# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(tree_sitter_python_library VERSION 0.0.1 LANGUAGES C)

add_library(tree_sitter_python SHARED
  "tree_sitter_python.c"
)

target_compile_definitions(tree_sitter_python PUBLIC DART_SHARED_LIB)
