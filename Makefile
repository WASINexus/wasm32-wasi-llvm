all: hello.wasm

hello.wasm:
	clang --target=wasm32-wasi --sysroot=/usr/share/wasi-sysroot -emit-llvm  -c -S -I./src/include ./src/wasm.c
	llc -march=wasm32 -filetype=obj wasm.ll
	wasm-ld --no-entry --strip-all --allow-undefined-file=./src/wasm.syms --export=load -o hello.wasm wasm.o -L /usr/share/wasi-sysroot/lib/wasm32-wasi -lc

install:
	install -d ./out ./out/res
	install ./hello.wasm ./src/index.html ./out
	install ./src/res/* ./out/res

clean:
	rm -rf ./out ./wasm.* ./hello.wasm
