#/bin/bash
set -e

sh stage0-binutils.sh
# sh stage1-clang.sh # Commenting clang because ideally it is not needed to build it, just have it installed