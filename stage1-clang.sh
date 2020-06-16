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
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-scei-ps4 \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCLANG_DEFAULT_CXX_STDLIB=libc++ \
    -DCOMPILER_RT_BUILD_BUILTINS:BOOL=ON \
    -DCOMPILER_RT_BUILD_SANITIZERS:BOOL=OFF \
    -DCOMPILER_RT_CAN_EXECUTE_TESTS:BOOL=OFF \
    -DCOMPILER_RT_INCLUDE_TESTS:BOOL=OFF \
    -DCLANG_BUILD_EXAMPLES:BOOL=ON \
    -DLLVM_TARGETS_TO_BUILD=X86 \
    -DCMAKE_C_FLAGS="-Wdocumentation -Wno-documentation-deprecated-sync" \
    -DCMAKE_CXX_FLAGS="-std=c++11 -Wdocumentation -Wno-documentation-deprecated-sync" \
    -DLLVM_LIT_ARGS="-v" \
    -G Ninja \
    ../llvm-project/llvm
    
cmake -j ${PROC_NR} --build . 
cmake --build . --target install -j ${PROC_NR}