local
  val vecAsWord: 'a vector -> word = RunCall.unsafeCast
  val intAsWord: int -> word = RunCall.unsafeCast
  fun unsafeSub (v: 'a vector, i: int) : 'a =
    RunCall.loadWordFromImmutable (vecAsWord v, intAsWord i)
in
  structure MLtonVector =
    Vector
      (open Vector
       structure VectorExtra = UnfoldiFromTabulate(Vector)
       open VectorExtra
       type 'a t = 'a vector
       val unsafeSub = unsafeSub)
end
