structure VectorExtra = UnfoldiFromTabulate(Vector)
structure MLtonVector =
  Vector
    (open Vector
     open VectorExtra
     type 'a t = 'a vector
     val unsafeSub = sub)