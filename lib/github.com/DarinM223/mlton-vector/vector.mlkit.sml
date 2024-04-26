local
  fun unsafeSub (a: 'a vector, i: int) : 'a =
    prim ("word_sub0", (a, i))
in
  structure MLtonVector =
    Vector
      (open Vector
       structure VectorExtra = UnfoldiFromTabulate(Vector)
       open VectorExtra
       type 'a t = 'a vector
       val unsafeSub = unsafeSub)
end
