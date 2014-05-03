open Core.Std


let readdir base =
  Array.map
    ~f:(fun file -> Filename.concat base file)
    (Sys.readdir base)
