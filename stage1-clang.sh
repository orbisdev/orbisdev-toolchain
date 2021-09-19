#/bin/bash
set -e

PROC_NR=$(getconf _NPROCESSORS_ONLN)

REPO_URL="https://github.com/llvm/llvm-project"
REPO_FOLDER="llvm-project"
BRANCH_NAME="llvmorg-13.0.0-rc3"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || exit 1
fi

cmake \
    -G "Unix Makefiles" -DLLVM_TARGETS_TO_BUILD="X86" \
    -S llvm -B build \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_INSTALL_PREFIX=${ORBISDEV}/ \
    -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-scei-ps4 \
    
cmake -j ${PROC_NR} --build . 
cmake -j ${PROC_NR} --target install