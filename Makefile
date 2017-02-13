LIB_NAME=raft-pb

LIB_FILES+=raft_pb
LIB_FILES+=raft_pb_conv

LIB_DEPS=raft,ocaml-protoc

## Generic library makefile ##

test: 
	$(OCB) test.native
	export OCAMLRUNPARAM="b" && ./test.native 

doc:
	$(OCB) src/$(LIB_NAME).docdir/index.html

gen:
	ocaml-protoc -ml_out src src/raft.proto

include Makefile.opamlib
