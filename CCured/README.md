# NesCheck on LLVM 10.0.0
For information of NesCheck, see the paper in [AsiaCCS 2017](https://hexhive.epfl.ch/publications/files/17AsiaCCS2.pdf). Here is the originl NesCheck [Repo](https://github.com/HexHive/nesCheck).

To put it simple, NesCheck analyzes and classifies pointers in terms of memory safety related operations (e.g., pointer arithmetic, type cast), the classification scheme is similar to [CCured](https://people.eecs.berkeley.edu/~necula/Papers/ccured_popl02.pdf).

Since the original NesCheck framework is designed for running on TinyOS and analyzing programs of embedded devices (written in nesC, a C dialect), to make it applicable to C and C++ programs and support Linux, we upgrade NesCheck pass to LLVM 10.0 on Ubuntu 20.04 with Linux kernel 5.8.0-48-generic. We also added a lot of new features to the original NesCheck, please refer to the code for the differences:)

## Installation
Make sure your base system is Ubuntu 20.04, this tool hasn’t been tested on other platforms up to now, so Ubuntu 20.04 is preferred.

### LLVM 10.0.0

This project reimplements NesCheck as an out-of-tree LLVM pass, which is different from the original NesCheck pass.

To compile an out-of-tree LLVM pass, the [prebuilt LLVM binaries](https://releases.llvm.org/download.html) are needed.

Or you can download them using apt:
```bash
apt install llvm-10 clang-10
```

### Build SVF

Please follow the official SVF setup [tutorial](https://github.com/svf-tools/SVF/wiki/Setup-Guide#getting-started).

The SVF code is available in ```CCured/program-dependence-graph/SVF```

### Build PDG

```
cd CCured/program-dependence-graph
mkdir build
cd build
cmake ..
make
```


### Build NesCheck

NesCheck is currently implemented as an out-of-tree pass, to build NesCheck, simply specify the ```LLVM_DIR``` along with the paths in ```CMakeLists.txt```.

Then run:

```
cmake .
cmake --build .
```

## Usage
Generate bitcode for ```neschecklib.c``` in the repo:
```bash
clang-10 -O0 -g -emit-llvm neschecklib.c -c -o neschecklib.bc
```

Link ```neschecklib.bc``` with the bitcode you want to analyze ```target.bc```:
```bash
llvm-link-10 neschecklib.bc target.bc -o target.linked.bc
```

In case you need help with building whole-program (or whole-library) LLVM bitcode files from an unmodified C or C++ source package, please see [wllvm](https://github.com/travitch/whole-program-llvm).

It's time to run the analysis:
```bash
opt-10 -o target.opt.bc -load libNesCheck.so -nescheck -stats -time-passes < target.linked.bc > target.nescheckout
```

After CCured analysis, you will get a bunch of pointers that are unsafe in terms of DataGuard's first stage analysis.

Note: This pass includes the taint analysis on detecting instructions that related to unsafe objects/pointers, which is still under-construction. If you face difficulties on running the analysis in a reasonable amount of time, please comment the related code in function ```identifyDifferentKindsOfUnsafePointers``` and use SVF for query aliasing instead of PDG.




