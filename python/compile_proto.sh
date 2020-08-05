#!/bin/bash
PROTO_FILE="../py.proto"

# check proto file
if test -f "$PROTO_FILE"; then
    echo "$PROTO_FILE exists"
else
    echo "$PROTO_FILE does't exist"
fi

# check python pacakge
if ! pip 1>/dev/null 2>&1; then
    echo "please prepare \`pip\` command"
    exit 1
fi

if ! pip freeze | grep -q grpcio-tools; then
    echo "please install package grpcio-tool: \`pip install grpcio-tool\`"
    exit 1
fi

# remove py_pb2*.py files
echo "remove py_pb2*.py files ..."
rm -rf py_pb*.py

# compile
echo "ready to compile the proto file ..."
python -m grpc_tools.protoc -I../ --python_out=. --grpc_python_out=. "$PROTO_FILE"
