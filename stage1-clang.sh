#/bin/bash
set -e

PROC_NR=$(getconf _NPROCESSORS_ONLN)

git clone --depth 1 https://github.com/llvm/llvm-project.git
mkdir build
cd build
cmake \
    -DLLVM_ENABLE_PROJECTS='clang;lld;compiler-rt' \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${ORBISDEV}/ \
    -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-scei-ps4 \
    -G Ninja \
    ../llvm-project/llvm
    
cmake -j ${PROC_NR} --build . 
cmake --build . --target install -j ${PROC_NR}