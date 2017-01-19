# abuild

The purpose of abuild is to to a single set of build scripts to enable
building applications and libraries on linux and windows(and hopefully OS X at
some point) using gcc and clang on linux and gcc/mingw and msvc on windows.

# Requirements

- A bash shell, MSYS2 on windows
- Able to build dependencies from the command line with gcc, clang, mingw and msvc
- Maintain only one set of build files/scripts(e.g No Visual Studio files)
- Modify compiler/link flags for all builds
- Build from git repository, source tarball, or use existing system binaries.
- Use bash shell script and python(No powershell)

# Design

The dependency building part of abuild is not specific to Ardour. It will be
similar to mingw-pkg.

Each package will have a single common script for building all packages

Each library has a script that defines prep/configure/build/install

The packages are installed similar to mingw-pkg where the install root can be
overidden for each dependency. When building the libraries the include/library
and pkg-config path will need to be overridden.

# System Setup

The script will determine the build system and dependent on the build options
will install the system packages required for the build, or if that is not
possible determine if the required packages are installed and print warnings
and directions on how to aquire the necessary build tools.

# Compiler Flags

respect CFLAGS, CXXFLAGS and LINKFLAGS

## Linux

## Windows

## OS X

# Script options

## Prep

## Configure

## Build

## Install

## Test

## Clean

# Configuration

The build and install directories will be determined by
$HOST_SYSTEM-$COMPILER-$HOST_ARCH 

e.g

install/windows-msvc-x86/bin
install/windows-msvc-x86/lib
install/windows-msvc-x86/include
install/windows-msvc-x86/share

install/windows-msvc-x86_64/bin

install/windows-mingw-x86/bin
install/windows-mingw-x86/lib

install/windows-mingw-x86_64/lib

install/linux-gcc-x86/bin

install/linux-clang-x86_64/bin

install/osx-clang-x86_64/bin

# Installer
