# python

A tiny exmaple of python gRPC services

# HOW TO

1. (optional) Prepare the python environment
2. Install the gRPC python package: grpcio-tools
    * `$ pip install -r requirements.txt`
3. Compile the proto file to generate python files
    * `$ ./compile_proto.sh`

# gRPC service

* An `exampleService` service with a `GetInfo()` function, which always return
  the message provided in console argument

* An gRPC client get the message from server

# Execute

## service:

```
$ python gRPC-service.py <messages>
```

## client:
```
$ python gRPC-client.py
```
