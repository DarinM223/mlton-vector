structure Assert =
struct
  fun fail msg =
    raise Fail (concat ["assertion failure: ", msg])

  fun assert (msg: string, f: unit -> bool) : unit =
    if not (f () handle _ => false) then fail msg else ()
end

signature FOLD_STRUCTS =
sig
  type 'a t
  type 'a elt

  val fold: 'a t * 'b * ('a elt * 'b -> 'b) -> 'b
end

signature FOLD =
sig
  include FOLD_STRUCTS

  val foldi: 'a t * 'b * (int * 'a elt * 'b -> 'b) -> 'b
  val foreachi: 'a t * (int * 'a elt -> unit) -> unit
  val foreach: 'a t * ('a elt -> unit) -> unit
  (* keepAll (l, f) keeps all x in l such that f x. *)
  val keepAll: 'a t * ('a elt -> bool) -> 'a elt list
  (* keepAllMap (l, f) keeps all y in l such that f x = SOME y.*)
  val keepAllMap: 'a t * ('a elt -> 'b option) -> 'b list
  val last: 'a t -> 'a elt
  val length: 'a t -> int
  val map: 'a t * ('a elt -> 'b) -> 'b list
  val mapi: 'a t * (int * 'a elt -> 'b) -> 'b list
  (* removeAll (l, f) removes all x in l such that f x. *)
  val removeAll: 'a t * ('a elt -> bool) -> 'a elt list
  (* The "rev" versions of functions are there for efficiency, when it is
   * easier to fold over the input and accumulate the result in reverse.
   *)
  val revKeepAll: 'a t * ('a elt -> bool) -> 'a elt list
  val revKeepAllMap: 'a t * ('a elt -> 'b option) -> 'b list
  val revRemoveAll: 'a t * ('a elt -> bool) -> 'a elt list
end

functor Fold(S: FOLD_STRUCTS): FOLD =
struct

  open S

  fun foldi (l: 'a t, b, f) =
    #1 (fold (l, (b, 0 : int), fn (x, (b, i)) => (f (i, x, b), i + 1)))

  fun foreachi (l, f) =
    foldi (l, (), fn (i, x, ()) => f (i, x))

  fun foreach (l, f: 'a elt -> unit) =
    fold (l, (), f o #1)

  fun last l =
    case fold (l, NONE, SOME o #1) of
      NONE => raise Fail "Fold.last"
    | SOME x => x

  fun length l =
    fold (l, 0 : int, fn (_, n) => n + 1)

  fun mapi (l, f) =
    rev (foldi (l, [], fn (i, x, l) => f (i, x) :: l))

  fun map (l, f) =
    mapi (l, f o #2)

  fun revKeepAllMap (l, f) =
    fold (l, [], fn (x, ac) =>
      case f x of
        NONE => ac
      | SOME y => y :: ac)

  fun keepAllMap z =
    rev (revKeepAllMap z)

  fun revKeepAll (l, f) =
    fold (l, [], fn (x, ac) => if f x then x :: ac else ac)

  fun keepAll z =
    rev (revKeepAll z)

  fun revRemoveAll (l, f) =
    fold (l, [], fn (x, ac) => if f x then ac else x :: ac)

  fun removeAll z =
    rev (revRemoveAll z)
end
