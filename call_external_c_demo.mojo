## calling external c function in the 
#### see a good zlib example: https://github.com/modularml/mojo/discussions/1861



from sys import ffi
from memory import UnsafePointer # c pointer

## 1. declare function signature in mojo, just like in C/C++
alias array_max_fn = fn(_ptr: UnsafePointer[Float64], _size: Int64) -> Float64

def callme():
    ## 2. load dynamic c lib
    var handle = ffi.DLHandle("./libdemo.so")
    ## 3. get function
    var array_max = handle.get_function[array_max_fn]('array_max')
    # 4. test data
    var vec = List[Float64]()
    vec.append(1.0)
    vec.append(2)
    vec.append(30)
    vec.append(51.112)
    vec.append(40)
    vec.append(51.0)
    var result = array_max(vec.data, len(vec))
    print("the max value is: ", result)
    ## pointer address
    print(vec.data)

def main():
    callme()