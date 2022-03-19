# Live Range Analysis

To use Live Variable analysis, please run make inside its directory.

Substitute /llvm/lib/CodeGen/LiveIntervals.cpp with the LiveIntervals.cpp in this directory before compile LLVM.

Detailed usage and description of the results coming soon.

For first stage analysis that compute stack objects that outlive the function call, please refers to llvm/lib/Analysis/CaptureTracking.cpp (also provided in this directory).
