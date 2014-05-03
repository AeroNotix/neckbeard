open Core.Std


module Message : sig
  type msg = { channel : string;
               nick : string;
               message : string;
               date : float;
             }
  type info = { channel : string;
                message : string;
                date : float;
              }
  type t = Msg of msg | Info of info | Invalid of string
  val of_string : raw:Core.Std.String.t -> channel:string -> t
  val of_file : string -> (t Core.Std.List.t, exn) Core.Std.Result.t
  val parse_directory :
    string -> (t Core.Std.List.t, exn) Core.Std.Result.t Core.Std.Array.t
end      
