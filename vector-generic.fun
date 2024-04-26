functor UnfoldiFromTabulate(V: VECTOR): VECTOR_STRUCTS =
struct
  open V
  type 'a t = 'a vector
  val unfoldi: int * 'b * (int * 'b -> 'a * 'b) -> 'a t * 'b =
    fn (n, init, f) =>
      let
        val s = ref init
      in
        ( V.tabulate (n, fn i =>
            let
              val (r, s') = f (i, !s)
              val () = s := s'
            in
              r
            end)
        , !s
        )
      end
end
