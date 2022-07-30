#/bin/bash
set -e

PROC_NR=$(getconf _NPROCESSORS_ONLN)

## Download the source code.
REPO_URL="https://github.com/bminor/binutils-gdb"
REPO_FOLDER="binutils-gdb"
BRANCH_NAME="binutils-2_38"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git checkout ${BRANCH_NAME} || exit 1
fi	
	
TARGET="x86_64-pc-freebsd9"
TARG_XTRA_OPTS=""

## Configure the build.
./configure \
  --quiet \
  --prefix="${ORBISDEV}" \
  --program-prefix=orbis- \
  --target="$TARGET" \
  --disable-sim \
  --disable-nls \
  --with-sysroot=/ \
  $TARG_XTRA_OPTS || { exit 1; }

## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR || { exit 1; }
make --quiet -j $PROC_NR install-strip || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }
