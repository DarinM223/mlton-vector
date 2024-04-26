mlton-vector
============

The MLton compiler has its own internal `Vector` type that has a lot of useful functions in it. It does not [expose](http://mlton.org/MLBasisAvailableLibraries) this type to MLton users as a library. This library gives access to the internal `Vector` type for multiple compilers (currently MLton, Poly/ML, and MLKit).