#/bin/bash
set -e

PROC_NR=$(getconf _NPROCESSORS_ONLN)

## Download the source code.
REPO_URL="https://github.com/bminor/binutils-gdb"
REPO_FOLDER="binutils-gdb"
BRANCH_NAME="binutils-2_36_1"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || exit 1
fi

./configure --prefix=${ORBISDEV} --target="x86_64-pc-freebsd9" \
	--disable-nls \
	--disable-dependency-tracking \
	--disable-werror \
	--enable-ld \
	--enable-lto \
	--enable-plugins \
	--enable-poison-system-directories  \
	--program-prefix=orbis-

## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR || { exit 1; }
make --quiet -j $PROC_NR install-strip || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }
