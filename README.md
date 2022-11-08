![CI](https://github.com/orbisdev/orbisdev-toolchain/workflows/CI/badge.svg)
![CI-Docker](https://github.com/orbisdev/orbisdev-toolchain/workflows/CI-Docker/badge.svg)

# orbisdev-toolchain

This program will automatically build and install the compiler tools used in the creation of homebrew software for the Sony PlayStation® 4 videogame system.

## **ATTENTION**

If you're trying to install in your machine the **WHOLE PS4 Development Environment**, this is **NOT** the repo to use! Instead, you should use instead the [orbisdev](https://github.com/orbisdev/orbisdev "orbisdev") repo.

## What these scripts do

These scripts download (with `git clone`) and install:

-   [binutils 2.38](http://www.gnu.org/software/binutils/ "binutils")
-   [llvm 15.0.4](https://llvm.org/ "llvm")

## Requirements

1.  Install gcc/clang, make, patch, git, texinfo, flex, bison, gsl, gmp, mpfr, mpc and gettext if you don't have those packages.
2.  Ensure that you have enough permissions for managing orbisdev location (which defaults to `/usr/local/orbisdev`). orbisdev location MUST NOT have spaces or special characters in it's path! For example, on Linux systems, you can set access for current user by running commands:
```bash
export orbisdev=/usr/local/orbisdev
sudo mkdir -p $orbisdev
sudo chown -R $USER: $orbisdev
```
3.  Add this to your login script (example: `~/.bash_profile`)
```bash
export orbisdev=/usr/local/orbisdev
export PS2SDK=$orbisdev/ps2sdk
export PATH=$PATH:$orbisdev/bin
```
4.  Run toolchain.sh
    `./toolchain.sh`