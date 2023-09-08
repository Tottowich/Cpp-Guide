# Setting Up VCPKG & CMake for Your C++ Projects 🛠

Welcome to the comprehensive guide on setting up VCPKG and CMake for your C++ projects! If you've ever struggled with managing dependencies and building your projects, you're in the right place. Let's get started! 🥧

## Table of Contents 📚
- [Setting Up VCPKG \& CMake for Your C++ Projects 🛠](#setting-up-vcpkg--cmake-for-your-c-projects-)
  - [Table of Contents 📚](#table-of-contents-)
  - [Introduction 🌟](#introduction-)
    - [What is VCPKG?](#what-is-vcpkg)
    - [What is CMake?](#what-is-cmake)
  - [Why VCPKG and CMake? ❓](#why-vcpkg-and-cmake-)
  - [Installing VCPKG 🔧](#installing-vcpkg-)
    - [For Linux/Mac](#for-linuxmac)
    - [For Windows](#for-windows)
  - [Installing CMake 🏗](#installing-cmake-)
  - [Understanding CMakeLists.txt 📜](#understanding-cmakeliststxt-)
  - [Using VCPKG to Install Libraries 📦](#using-vcpkg-to-install-libraries-)
  - [Integrating VCPKG with CMake 🔗](#integrating-vcpkg-with-cmake-)
  - [Using Installed Libraries in Your Code 📄](#using-installed-libraries-in-your-code-)
    - [In `.cpp` files:](#in-cpp-files)
    - [In `.h` files:](#in-h-files)
  - [Building and Compiling Projects 🔨](#building-and-compiling-projects-)
    - [Basic Build](#basic-build)
    - [Build with External Dependencies](#build-with-external-dependencies)

---

## Introduction 🌟

### What is VCPKG?

VCPKG is a command-line package manager that simplifies the process of managing C and C++ libraries. It automates the steps of downloading, building, and installing libraries, saving you a ton of manual work.

### What is CMake?

CMake is not a compiler. Instead, it's a build system generator. It generates the files needed for building your project, based on the operating system and the compiler you are using. In other words, it's a meta-build system that allows you to build projects in a compiler-agnostic manner.

---

## Why VCPKG and CMake? ❓


1. **Simplified Dependency Management**: Instead of manually downloading and compiling libraries, VCPKG does it for you.
2. **Cross-Platform Compatibility**: Develop your project on multiple platforms without worrying about system-specific quirks.
3. **Community Support**: Both tools are open-source and have robust community contributions, which means you can find a solution for almost any problem you might encounter.
4. **Scalability**: These tools are suitable for both small and large projects, providing a consistent way to manage them.

---

## Installing VCPKG 🔧

### For Linux/Mac
``` bash
# Clone VCPKG GitHub repository and navigate into it
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg

# Run the bootstrap script to build VCPKG
./bootstrap-vcpkg.sh
```

### For Windows
``` bash
# Clone VCPKG GitHub repository and navigate into it
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg

# Run the bootstrap script to build VCPKG
.\bootstrap-vcpkg.bat
```

---

## Installing CMake 🏗


Visit the [CMake Official Website](https://cmake.org/download/) to download the installer suitable for your operating system. Follow the installation wizard steps, and don't forget to add CMake to your system PATH when prompted. You can verify the installation by opening a terminal and running `cmake --version`.


---

## Understanding CMakeLists.txt 📜


A `CMakeLists.txt` file is the heart of a CMake project. It contains CMake commands and instructions needed to build your project. You usually create one in your project's root directory and additional subdirectories as needed. The file defines build targets, linked libraries, and other compile settings.

To create a simple `CMakeLists.txt` file, you can use a text editor. Here's a minimal example:

``` cmake
cmake_minimum_required(VERSION 3.10)
project(MyProject)
add_executable(MyProject main.cpp)
```

---

## Using VCPKG to Install Libraries 📦


To install a library, use the `vcpkg install` command followed by the library name. VCPKG will download, build, and install the library for you. For example, to install the popular `boost` library, you would do the following:

``` bash
./vcpkg install boost
```

---

## Integrating VCPKG with CMake 🔗


Integrating VCPKG with CMake is straightforward. Simply set the `CMAKE_TOOLCHAIN_FILE` variable to point to the VCPKG toolchain file, which is usually located in `<vcpkg_root>/scripts/buildsystems/vcpkg.cmake`. Here's an example of a `CMakeLists.txt` file that includes VCPKG:

``` cmake
cmake_minimum_required(VERSION 3.0)
project(MyProject)

# Integrate VCPKG with CMake
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake)

add_executable(MyProject main.cpp)
```

---

## Using Installed Libraries in Your Code 📄


After installing a library via VCPKG, you can include its headers and link against it just like any other library. For example, if you've installed the `boost` library, you can include its headers in your `.cpp` and `.h` files as shown below:


### In `.cpp` files:

``` cpp
#include <boost/algorithm/string.hpp>
```

### In `.h` files:

``` cpp
#include <boost/algorithm/string.hpp>
```

---

## Building and Compiling Projects 🔨


Building your project involves two main steps: configuring and generating build files with CMake, and then compiling the code using those build files. This can be done via the command line as shown:

### Basic Build

``` bash
# Create a build directory and navigate into it
mkdir build
cd build

# Generate build files with CMake
cmake ..

# Compile the project
cmake --build .
```

### Build with External Dependencies

``` bash
# Generate build files, including the VCPKG toolchain
cmake -DCMAKE_TOOLCHAIN_FILE=<path-to-vcpkg>/scripts/buildsystems/vcpkg.cmake ..

# Compile the project
cmake --build .
```

---

Congratulations, you're now equipped with the basic knowledge to efficiently manage C++ dependencies and build your projects using VCPKG and CMake. Happy coding! 🚀
