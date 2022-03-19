# Value Range Analysis

## Building the tool
To build the CCured analysis with Value Range analysis, copy and substitute the files in this directory to the CCured directory.

## Running the tool

Similar to the usage of CCured.
   
## Results

Here is 2 examples of the output results:

```
This is a structure!
Direct Use Site: SPEC2006/benchspec/CPU2006/429.mcf/src/pbeampp.c:103:9
Indirect Use Site: SPEC2006/benchspec/CPU2006/429.mcf/src/pbeampp.c:101:9
Definition Site: SPEC2006/benchspec/CPU2006/429.mcf/src/pbeampp.c:81:25, In Func: sort_basket, At Line: 81
Declared Size: 24, Access Range: 16
Classify this structure as safe!

This is an array!
Direct Use Site: SPEC2006/benchspec/CPU2006/429.mcf/src/pbeampp.c:103:9
Indirect Use Site: SPEC2006/benchspec/CPU2006/429.mcf/src/pbeampp.c:101:9
Definition Site: SPEC2006/benchspec/CPU2006/429.mcf/src/pbeampp.c:81:16, In Func: sort_basket, At Line: 81
Declared Size: 2808, Access Range: Undetermined!
Classify this array as unsafe!
```

The information we can gain from the results are the definition and use sites of the ```seq``` pointer, whether it points to ```structure``` type or ```array``` type, the object's ```declared size```, and the ```access range``` (from offset 0) through the pointer.

If the ```declared size``` is greater than or equal to the ```access range```, we deem this ```seq``` pointer as safe.

If the ```declared size``` is less than the ```access range```, we deem this ```seq``` pointer as unsafe.

If the ```access range``` is not a constant value (i.e., ```llvm::ConstantInt```), we deem this ```seq``` pointer as unsafe.

Also, due to the context sensitivity issue of the analysis, as described in the paper, many ```seq``` pointers that are deemed as unsafe may actually be safe. Thus, for all the unsafe ```seq``` pointers identified by value-range analysis, we will need to use symbolic execution (```s2e```) to query its ```access range```. The start and end points of the symbolic execution are specified in the results of value-range analysis (i.e., definition and use sites). 

To save the cost of symbolic execution, we set context-sensitivity level and use symbolic state merging technique in ```s2e```, please refer to their document for how to use them properly. Also, for the trivial cases, we manually check all the unsafe ```seq``` pointers by the value-range analysis and filter out the cases that can be deemed as safe or unsafe easily without using symbolic execution.

Note: the value-range analysis runs pretty fast on some of the programs while slow on others, please be patient for the results, we will keep updating the repo for fixing any issues.
