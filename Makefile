version = 0.21.0

init:
	mkdir -p build
	curl https://github.com/tree-sitter/tree-sitter-python/archive/refs/tags/v${version}.tar.gz -Lo build/src.tar.gz
	tar -xf build/src.tar.gz -C build
	cp -rT build/tree-sitter-python-${version}/src src/tree-sitter-python
