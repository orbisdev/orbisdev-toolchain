#/bin/bash
set -e

PROC_NR=$(getconf _NPROCESSORS_ONLN)

REPO_URL="https://github.com/llvm/llvm-project"
REPO_FOLDER="llvm-project"
BRANCH_NAME="llvmorg-15.0.4"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || exit 1
fi

cmake \
    -G "Unix Makefiles" \
    -S llvm -B build \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_INSTALL_PREFIX=${ORBISDEV}/ \
    -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-scei-ps4 \
    || exit 1
    

## Enter in build folder
cd build || exit 1

## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR || { exit 1; }
make --quiet -j $PROC_NR install || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }
