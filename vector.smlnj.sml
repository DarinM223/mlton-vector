structure MLtonVector =
  Vector
    (open Vector
     structure VectorExtra = UnfoldiFromTabulate(Vector)
     open VectorExtra
     type 'a t = 'a vector
     val unsafeSub = Unsafe.Vector.sub)
