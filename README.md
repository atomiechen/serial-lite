# serial-lite

A lite version of cross-platform c++ serial port library [wjwwood/serial](https://github.com/wjwwood/serial), without original installation steps on use. It turns out that the original installation steps are annoying for me because I do not want cmake and especially, catkin, as dependencies.

You can build your own dynamic and static `serial` libraries for portable use, or install them to your system. Example makefile is provided to build example codes using this library.



## How to build libraries

Core sources of [wjwwood/serial](https://github.com/wjwwood/serial) are included in folder `include` (header files) and `src` (implementations). Use make commands to build library files in `lib` folder: 

```sh
## build both dynamic and static libraries
make
## build static library file libserial.a
make slib
## build dynamic library file libserial.so
make dlib
## install both files to system (not for Windows)
make install
## uninstall (not for Windows)
make uninstall
## print useful info
make info
## build example codes (specify STATIC to use static library or not)
make examples [STATIC=true]
```



## How to use

### Installed (not for Windows)

If you installed your libraries to your system, you can use flag `-lserial` to link:

```sh
g++ main.cpp -o main -lserial
```

### Not installed

An example file from [wjwwood/serial](https://github.com/wjwwood/serial) is also provided here in `examples` folder, along with an example makefile to build the executable:

```sh
cd examples
## use dynamic library to build executable
make

## If you want to use static library instead, 
## pass different STATIC value to the make tool:
make rebuild STATIC=true

## print useful info, and you can see flags
## intended for the compiler
make info
make info STATIC=true
```

Note this `Makefile` in `examples` folder includes `detect_OS.mk` in the root directory, and if you want to use somewhere else you should copy both files or combine them. `detect_OS.mk` is for detecting OS info and necessary for further build.

Some specifics: 

- macOS: 

  - If linking the static library, you need to add framework flags to support serial port enumeration: 

    ```sh
    -framework CoreFoundation -framework IOKit
    ```

  - A dynamic library has its install name and the executable will find it according to this name. In this project, the built `libserial.so`'s name is `libserial.so`, thus the executable will find it locally (or in system configured paths if fails). One needs to put the executable and dynamic library together to make them work.
  
- Windows

  - If linking the static library, you need to link SetupAPI to support serial port enumeration (Note: libraries need to be specified last when using MinGW, https://stackoverflow.com/a/46263157/11854304)：

    ```sh
    -lsetupapi
    ```

  - The output dynamic library file's suffix is `dll`.

  - To run `make clean` and `make veryclean` you need a Unix shell like git-bash. You can use Cmder.



## Dependencies

- g++: for library generation
  - ar: for static library
- GNU make: for automatic OS detection and build
  - Unix-like shell (bash/zsh/...) or that supports unix-like path & commands (e.g. rm)



## TODO

Support for Linux.



## About [wjwwood/serial](https://github.com/wjwwood/serial)

[![Build Status](https://travis-ci.org/wjwwood/serial.svg?branch=master)](https://travis-ci.org/wjwwood/serial)*(Linux and OS X)* [![Build Status](https://ci.appveyor.com/api/projects/status/github/wjwwood/serial)](https://ci.appveyor.com/project/wjwwood/serial)*(Windows)*

This is a cross-platform library for interfacing with rs-232 serial like ports written in C++. It provides a modern C++ interface with a workflow designed to look and feel like PySerial, but with the speed and control provided by C++. 

This library is in use in several robotics related projects and can be built and installed to the OS like most unix libraries with make and then sudo make install, but because it is a catkin project it can also be built along side other catkin projects in a catkin workspace.

Serial is a class that provides the basic interface common to serial libraries (open, close, read, write, etc..) and requires no extra dependencies. It also provides tight control over timeouts and control over handshaking lines. 

### Documentation

Website: http://wjwwood.github.com/serial/

API Documentation: http://wjwwood.github.com/serial/doc/1.1.0/index.html



For more details, please refer to their [website](http://wjwwood.github.com/serial/) and [github](https://github.com/wjwwood/serial).



## Authors

Atomie CHEN <atomic_cwh@163.com>

### Original authors of [wjwwood/serial](https://github.com/wjwwood/serial): 

William Woodall <wjwwood@gmail.com>
John Harrison <ash.gti@gmail.com>