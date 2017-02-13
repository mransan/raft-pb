OCB_INC   = -I src -I tests
OCB_FLAGS = -use-ocamlfind -pkgs raft,ocaml-protoc
OCB       = ocamlbuild $(OCB_FLAGS) $(OCB_INC)

.PHONY: test gen lib.native lib.byte lib.install lib.uninstall clean doc 

test: 
	$(OCB) test.native
	export OCAMLRUNPARAM="b" && ./test.native 

gen:
	ocaml-protoc -ml_out src src/raft.proto

LIB_NAME=raft-pb

lib.native:
	$(OCB) $(LIB_NAME).cmxa
	$(OCB) $(LIB_NAME).cmxs

lib.byte:
	$(OCB) $(LIB_NAME).cma

LIB_FILES+=raft_pb
#LIB_FILES+=raft_pb_conv

LIB_BUILD     =_build/src/
LIB_INSTALL   = META 
LIB_INSTALL  +=$(patsubst %,$(LIB_BUILD)/%.mli,$(LIB_FILES))
LIB_INSTALL  +=$(patsubst %,$(LIB_BUILD)/%.cmi,$(LIB_FILES))
LIB_INSTALL  +=$(patsubst %,$(LIB_BUILD)/%.annot,$(LIB_FILES))
LIB_INSTALL  +=$(patsubst %,$(LIB_BUILD)/%.cmo,$(LIB_FILES))
LIB_INSTALL  +=$(LIB_BUILD)/$(LIB_NAME).cma 

LIB_INSTALL  +=-optional  
LIB_INSTALL  +=$(patsubst %,$(LIB_BUILD)/%.cmx,$(LIB_FILES))
LIB_INSTALL  +=$(patsubst %,$(LIB_BUILD)/%.cmt,$(LIB_FILES))
LIB_INSTALL  +=$(LIB_BUILD)/$(LIB_NAME).cmxa 
LIB_INSTALL  +=$(LIB_BUILD)/$(LIB_NAME).cmxs
LIB_INSTALL  +=$(LIB_BUILD)/$(LIB_NAME).a

lib.install:
	ocamlfind install $(LIB_NAME) $(LIB_INSTALL)

lib.uninstall:
	ocamlfind remove $(LIB_NAME)

clean:
	$(OCB) -clean

doc:
	$(OCB) src/raft.docdir/index.html
