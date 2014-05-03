open Core.Std


module Message : sig

  type t

  val message_of_string : string -> t

end
