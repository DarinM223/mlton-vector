structure Main =
struct
  fun main () =
    let
      val v = MLtonVector.fromList [1, 2, 3]
      val v' = MLtonVector.fromList [2, 3, 4]
      val () = print "foreach2:\n"
      val () = MLtonVector.foreach2 (v, v', fn (a, b) =>
        (print (Int.toString a); print (Int.toString b); print "\n"))
      val () = print "keepAllMap:\n"
      val v'' = MLtonVector.keepAllMap (v, fn i =>
        if i > 1 then SOME i else NONE)
      val () = MLtonVector.foreach (v'', fn a => print (Int.toString a))
      val () = print "\n"
      val () = print "concat & concatV:\n"
      val v''' = MLtonVector.concat [v, v']
      val () = MLtonVector.foreach (v''', fn a => print (Int.toString a))
      val () = print "\n"
      val v''' = MLtonVector.concatV (MLtonVector.fromList [v, v'])
      val () = MLtonVector.foreach (v''', fn a => print (Int.toString a))
      val () = print "\n"
    in
      ()
    end
end
