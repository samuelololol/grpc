#!/bin/bash
PROTO_FILE="./py.proto"
PROTO_ORI_FILE="../py.proto"
GOPATH=$HOME/go
GOBIN=$GOPATH/bin
PATH=$PATH:$GOBIN:$GOPATH/bin
GENERATED_FILE="./samuel.com/pbinfo/py.pb.go"

# clean up proto file
rm -rf "$PROTO_FILE" samuel.com go.mod go.sum
cp "$PROTO_ORI_FILE" .

# check proto file
if test -f "$PROTO_FILE"; then
    echo "$PROTO_FILE exists"
else
    echo "$PROTO_FILE does't exist"
    exit 1
fi

# check python pacakge
if ! protoc > /dev/null 2>&1; then
    echo "please prepare \`protoc\` command"
    exit 1
fi

if go list github.com/golang/protobuf/protoc-gen-go | grep -q grpcio-tools; then
    echo "please install package grpcio-tool: \`go get -u github.com/golang/protobuf/protoc-gen-go\`"
    exit 1
fi

# remove py_pb2*.py files
echo "remove golang files ..."
rm -rf py.pb.go

# compile
echo "ready to compile the proto file ..."
protoc --proto_path=. --go_out=plugins=grpc:. "$PROTO_FILE"

# move files
if test -f "$GENERATED_FILE"; then
    echo "$GENERATED_FILE exists"
    mv "$GENERATED_FILE" .
    rm -rf samuel.com
else
    echo "$GENERATED_FILE does't exist"
    exit 1
fi

go mod init samuel.com/pbinfo
