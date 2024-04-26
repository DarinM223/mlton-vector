structure MLtonVector =
  Vector
    (open Vector
     open MLton.Vector
     type 'a t = 'a vector
     val unsafeSub = Unsafe.Vector.sub)
