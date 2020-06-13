#/bin/bash
set -e

ROOT=${PWD}
PS4TOOLCHAIN=${ROOT}/toolchain
PROC_NR=$(getconf _NPROCESSORS_ONLN)

git clone --depth 1 https://github.com/bminor/binutils-gdb
cd binutils-gdb

./configure --prefix=${PS4TOOLCHAIN} --target="x86_64-pc-freebsd9" \
	--disable-nls \
	--disable-dependency-tracking \
	--disable-werror \
	--enable-ld \
	--enable-lto \
	--enable-plugins \
	--enable-poison-system-directories
make -j ${PROC_NR}
make install

cd ${PS4TOOLCHAIN}/bin
ln -s x86_64-pc-freebsd9-ld orbis-ld