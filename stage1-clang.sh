#/bin/bash
set -e

PROC_NR=$(getconf _NPROCESSORS_ONLN)

mkdir llvm && cd llvm || { exit 1; }

bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh

./llvm.sh 13
