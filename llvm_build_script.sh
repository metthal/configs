#!/bin/bash

VER=$(basename $1)
CPUS=$(nproc)

check_file() {
	if [ ! -f "$1-$VER.src.tar.xz" ]; then
		echo "Missing file - $1" >&2
		exit 1
	fi
}

move() {
	mv $1-$VER.src $2
}

pushd $2
pushd $VER

check_file "llvm"
check_file "cfe"

for file in *.xz; do
	xz -dvk "$file"
done

for file in *.tar; do
	tar -xvf "$file"
	rm "$file"
done

move "llvm" "llvm"
move "cfe" "llvm/tools/clang"

INSTALL_PATH=$(realpath $PWD/llvm-install)
rm -rf llvm-build && mkdir llvm-build
cd llvm-build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH -G "Unix Makefiles" ../llvm
make -j$CPUS install

popd
popd
