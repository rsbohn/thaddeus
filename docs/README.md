# Thaddeus - A Little Smalltalk for 65186

This is a new implementation of Timothy Budd's Little Smalltalk. [http://web.engr.oregonstate.edu/~budd/]

## Source files

. src/monitor.a -- Cold boot, initialize video and serial ports, run 'bootsector'. Also basic IO routines.
. src/bytecodes.a -- This is the bytecode interpreter. Also here you find 'bootsector'.
. src/primitives.a -- The primitives.
. src/memory.a -- Allocate memory in the object store $8000 to $EEFF etc.
. src/macros.a -- macros

## Memory, ByteArray and SmallInt

Objects in the object store are word aligned. Bit 0 of the object address is always 0.

SmallInts are treated as literals. Any object where Bit 0 is a 1 is a SmallInt. 
`addr >> 1` gets the actual value. `value << 1 + 1` to make it an object.

ByteArrays are marked as such using `value && $8000`.

Objects other than SmallInt have a size and a pointer to their class, followed by the object content.

## Changes from Budd

One of the challenges is understanding the optimizations in LST4 and deciding what to keep.

. ByteArray: LST4 shifts the size and adds two flags in bytes 1,0. Thaddeus puts the flags in bytes 15,14 instead. 
This allows using the negative bit as the 'This is a ByteArray' flag.
. Maths: Pointers are 16 bits. SmallInt is (will be) 15 bits instead of 31 bits.

## Garbage Collection

Not yet implemented.

## Missing Bytecodes and Primitives

This is a work in progress, still much to be implemented.

## Preview

To actually run this code you need the Pluton/0 emulator.

Set a breakpoint at $F800 and run to the breakpoint.

Change the instruction pointer (RW) to $0030. Set RIV, RCA, RCT as you like.

Enter your bytecode at $0030. Use #(F6 30 00) to make an infinite loop.

Clear breakpoint 1 and set a new breakpoint at $F850, now you can step the loop one iteration at a time.

Run LST4 elsewhere and use it to get bytecodes. The same bytecodes should work in the emulator, modulo pointer size as mentioned above.
