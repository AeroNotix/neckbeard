open Core.Std
module T = Core.Time


module Message = struct

  exception Invalid_message_format of string
  
  type msg = { channel : string
             ; nick    : string
             ; message : string
             ; date    : float
             }

  type info = { channel : string
              ; message : string
              ; date    : float
              }
                
  type t =
    | Msg of msg
    | Info of info

  let is_info_marker = function
    | "<--" -> true
    | "-->" -> true
    | _     -> false

  let of_date_string s =
    (T.of_string s) |> T.to_float

  let of_string ~raw ~channel =
    let msg = String.split raw '\t' in
    match msg with
    | [date; nick; message] when is_info_marker nick ->
       let date = of_date_string date in
       Info {channel;message;date}
    | [date; nick; message] ->
       let date = of_date_string date in
       Msg {channel;nick;message;date}
    | _ -> raise (Invalid_message_format raw)
end

