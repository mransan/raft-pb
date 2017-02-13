

open Raft_pb_conv

let () = 
  let _ = log_entry_to_pb {
    Raft_log.index = 1; 
    term = 1; 
    id = "one";
    data = Bytes.of_string "one";
  } in 
  print_endline "Hello world"
