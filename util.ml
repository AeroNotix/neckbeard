open Core.Std


let is_directory path =
  match Sys.is_directory path with
  | `Yes -> true
  | `Unknown | `No -> false

let rec readdir ?(recurse=false) base =
  let rec aux acc = function
    | [] -> List.rev acc
    | hd :: tl when is_directory hd ->
       aux (hd :: (readdir ~recurse:recurse hd @ acc)) tl
    | hd :: tl -> aux (hd :: acc) tl in
  let topbase = Array.map
               ~f:(fun file -> Filename.concat base file)
               (Sys.readdir base)
             |> Array.to_list in
  if recurse then
    topbase @ aux [] topbase
  else
    topbase
