module L = Raft_log 
module T = Raft_types 
module P = Raft_pb 

let log_entry_to_pb {L.index;term;data;id} = 
  {P.index; term; data; id}

let log_entry_of_pb {P.index;term;data;id} = 
  {L.index; term; data; id}

let request_vote_request_to_pb t = 
  let {
    T.candidate_term; 
    candidate_id; 
    candidate_last_log_index; 
    candidate_last_log_term; 
  }  = t in {
    P.candidate_term; 
    candidate_id; 
    candidate_last_log_index; 
    candidate_last_log_term; 
  }

let request_vote_request_of_pb pb = 
  let {
    P.candidate_term; 
    candidate_id; 
    candidate_last_log_index; 
    candidate_last_log_term; 
  }  = pb in {
    T.candidate_term; 
    candidate_id; 
    candidate_last_log_index; 
    candidate_last_log_term; 
  }

let request_vote_response_to_pb t = 
  let {
    T.voter_id;
    voter_term;
    vote_granted;
  } = t in  {
    P.voter_id;
    voter_term;
    vote_granted;
  }

let request_vote_response_of_pb pb = 
  let {
    P.voter_id;
    voter_term;
    vote_granted;
  } = pb in  {
    T.voter_id;
    voter_term;
    vote_granted;
  }

let append_entries_request_to_pb t = 
  let {
    T.leader_term;
    leader_id;
    prev_log_index;
    prev_log_term;
    rev_log_entries;
    leader_commit;
  } = t in {
    P.leader_term;
    leader_id;
    prev_log_index;
    prev_log_term;
    rev_log_entries = List.map log_entry_to_pb rev_log_entries;
    leader_commit;
  }

let append_entries_request_of_pb pb = 
  let {
    P.leader_term;
    leader_id;
    prev_log_index;
    prev_log_term;
    rev_log_entries;
    leader_commit;
  } = pb in {
    T.leader_term;
    leader_id;
    prev_log_index;
    prev_log_term;
    rev_log_entries = List.map log_entry_of_pb rev_log_entries;
    leader_commit;
  }

let append_entries_response_result_to_pb = function
  | T.Success receiver_last_log_index -> 
    P.Success {P.receiver_last_log_index;} 
  | T.Log_failure receiver_last_log_index -> 
    P.Log_failure {P.receiver_last_log_index;} 
  | T.Term_failure -> P.Term_failure

let append_entries_response_result_of_pb = function
  | P.Success {P.receiver_last_log_index;}  -> 
    T.Success receiver_last_log_index
  | P.Log_failure {P.receiver_last_log_index;} ->
    T.Log_failure receiver_last_log_index 
  | P.Term_failure -> T.Term_failure

let append_entries_response_to_pb t = 

  let {
    T.receiver_id;
    receiver_term;
    result;
  } = t in  {
    P.receiver_id;
    receiver_term;
    result = append_entries_response_result_to_pb result;
  }

let append_entries_response_of_pb pb = 

  let {
    P.receiver_id;
    receiver_term;
    result;
  } = pb in  {
    T.receiver_id;
    receiver_term;
    result = append_entries_response_result_of_pb result;
  }

let message_to_pb = function 
  | T.Request_vote_request 	 	x -> P.Request_vote_request 	 	(request_vote_request_to_pb x)
  | T.Request_vote_response  	x -> P.Request_vote_response  	(request_vote_response_to_pb x)
  | T.Append_entries_request 	x -> P.Append_entries_request 	(append_entries_request_to_pb x)
  | T.Append_entries_response	x -> P.Append_entries_response	(append_entries_response_to_pb x)

let message_of_pb = function 
  | P.Request_vote_request 	 	x -> T.Request_vote_request 	 	(request_vote_request_of_pb x)
  | P.Request_vote_response  	x -> T.Request_vote_response  	(request_vote_response_of_pb x)
  | P.Append_entries_request 	x -> T.Append_entries_request 	(append_entries_request_of_pb x)
  | P.Append_entries_response	x -> T.Append_entries_response	(append_entries_response_of_pb x)
