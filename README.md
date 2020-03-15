# serial-lite

A lite version of cross-platform c++ serial port library [wjwwood/serial](https://github.com/wjwwood/serial), without original installation steps on use. You only need to copy these files to your project, build your own dynamic library file, and use it to link with your own compiled codes.

It turns out that the original installation steps are annoying for me because I do not want  cmake and especially, catkin, as dependencies.



## How to use

All sources of [wjwwood/serial](https://github.com/wjwwood/serial) are included in folder `libserial`. In this folder you can build your own dynamic library `libserial.so` for your platform by make:

```sh
cd libserial
make
```

Then you can use the Makefile back in the root directory to compile your own code. Or you can adapt to your project. The keys are the compile flags for include path and library:

```makefile
## in root folder
INCLUDE = -Ilibserial/include
LIBS = -Llibserial -lserial
```

For simple use, you can just copy your `.cpp` and `.h` files to the root folder and use make command to build executable:

```sh
## in root folder
make
```



## Dependencies

- g++: for dynamic library generation
- make: for automatic OS detection



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