BIN_DIR = bin
PROTO_DIR = proto
SERVER_DIR = server
CLIENT_DIR = client
SHELL := bash
SHELL_VERSION = $(shell echo $$BASH_VERSION)
UNAME := $(shell uname -s)
VERSION_AND_ARCH = $(shell uname -rm)
OS = macos ${VERSION_AND_ARCH}
PACKAGE = $(shell head -1 go.mod | awk '{print $$2}')
RM_F_CMD = rm -f
RM_RF_CMD = ${RM_F_CMD} -r
SERVER_BIN = ${SERVER_DIR}
CLIENT_BIN = ${CLIENT_DIR}
.PHONY: blog
project := blog
all: $(project)
blog:

$(project):
	protoc --proto_path=${PROTO_DIR} --go_opt=paths=source_relative --go_out=${PROTO_DIR} --go-grpc_opt=paths=source_relative --go-grpc_out=${PROTO_DIR}  ./${PROTO_DIR}/*.proto
	go build -o ${BIN_DIR}/${SERVER_BIN} ./${SERVER_DIR}
	go build -o ${BIN_DIR}/${CLIENT_BIN} ./${CLIENT_DIR}

clean: clean_blog
	${RM_F_CMD} ssl/*.crt
	${RM_F_CMD} ssl/*.csr
	${RM_F_CMD} ssl/*.key
	${RM_F_CMD} ssl/*.pem
	${RM_RF_CMD} ${BIN_DIR}

clean_blog:
	${RM_F_CMD} ./${PROTO_DIR}/*.pb.go