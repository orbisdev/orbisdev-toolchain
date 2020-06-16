#/bin/bash
set -e

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
	--enable-poison-system-directories  \
	--program-prefix=orbis-
make -j ${PROC_NR} CFLAGS="$CFLAGS -O2" LDFLAGS="$LDFLAGS -s"
make install -j ${PROC_NR}
