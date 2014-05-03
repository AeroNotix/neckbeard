open Core.Std
module T = Core.Time


module Message = struct

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
    | Invalid of string

  let is_info_marker = function
    | "<--" -> true
    | "-->" -> true
    | "--"  -> true
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
    | _ -> Invalid raw

  let of_file path =
    let process_line line =
      of_string ~raw:line ~channel:path in
    let file = open_in path in
    let messages =
      try
        Result.Ok (file
                   |> Std.input_list
                   |> List.map ~f:process_line)
      with e ->
        Result.Error e in
    In_channel.close file;
    messages

  let parse_directory dir =
    Array.map ~f:of_file
              (Util.readdir dir)

end
