# abuild

The purpose of abuild is to to a single set of build scripts to enable
building applications and libraries on linux and windows(and hopefully
OS X at some point) using gcc and clang on linux and gcc/mingw and msvc
on windows.

# Requirements

- A bash shell, MSYS2 on windows
- Able to build dependencies from the command line with gcc, clang,
  mingw and msvc
- Maintain only one set of build files/scripts(e.g No Visual Studio
  files)
- Modify compiler/link flags for all builds
- Build from git repository, source tarball, or use existing system
  binaries.
- Use bash shell script and python(No powershell)
- Override Build directory with an environment variable to be able to
  use local checkout/extracted tarball/etc for development
- Easily install into system locations, default install directory or
  specified path.

# Design

The dependency building part of abuild is not specific to Ardour. It
will be similar to mingw-pkg.

Each package will have a single common script for building all packages

Each library has a script that defines prep/configure/build/install

The packages are installed similar to mingw-pkg where the install root
can be overridden for each dependency. When building the libraries the
include/library and pkg-config path will need to be overridden.

# System Setup

The script will determine the build system and dependent on the build
options will install the system packages required for the build, or if
that is not possible determine if the required packages are installed
and print warnings and directions on how to aquire the necessary build
tools.

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

The default build root directory name is determined by
$PLATFORM-$TOOLSET-$HOST_ARCH in order to have separate builds and speed
up compilation (useful for platforms without a compiler cache).

The build directory can be overridden by the PKG_BUILD_ROOT_DIR
environment variable in order to allow development in a separate
directory (with read-write repositories for instance). The package
directory within the PKG_BUILD_ROOT_DIR must match the name of the
package.

The default install directories will be determined by
$PKG_NAME-$PKG_VERSION-$PKG_RELEASE-$PLATFORM-$TOOLSET-$HOST_ARCH

e.g

install/awesome-app-1.0-1-windows-msvc-i686
install/awesome-app-1.0-1-windows-mingw-x86_64

install/awesome-app-1.0-1-linux-gcc-x86_64

install/awesome-app-1.0-2-linux-clang-x86_64

install/awesome-app-1.0-3-macos-clang-x86_64

# Installer
