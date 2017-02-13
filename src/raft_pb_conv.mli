val log_entry_of_pb : Raft_pb.log_entry -> Raft_log.log_entry
val log_entry_to_pb : Raft_log.log_entry -> Raft_pb.log_entry

val request_vote_request_of_pb : Raft_pb.request_vote_request -> Raft_types.request_vote_request
val request_vote_request_to_pb : Raft_types.request_vote_request -> Raft_pb.request_vote_request

val request_vote_response_of_pb : Raft_pb.request_vote_response -> Raft_types.request_vote_response
val request_vote_response_to_pb : Raft_types.request_vote_response -> Raft_pb.request_vote_response

val append_entries_request_of_pb : Raft_pb.append_entries_request -> Raft_types.append_entries_request
val append_entries_request_to_pb : Raft_types.append_entries_request -> Raft_pb.append_entries_request

val append_entries_response_of_pb : Raft_pb.append_entries_response -> Raft_types.append_entries_response
val append_entries_response_to_pb : Raft_types.append_entries_response -> Raft_pb.append_entries_response

val message_of_pb : Raft_pb.message -> Raft_types.message
val message_to_pb : Raft_types.message -> Raft_pb.message
