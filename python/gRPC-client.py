#!/usr/bin/env python
"""
Description:

Date: Aug 05, 2020
Author: samuel
"""
import grpc
import py_pb2
import py_pb2_grpc

def get_info(stub, req):
    msg = stub.GetInfo(req)
    return msg


def main():
    """Main function"""
    with grpc.insecure_channel('localhost:8081') as channel:
        print('(channel is good)')
        stub = py_pb2_grpc.exampleServiceStub(channel)
        print('(stub is good)')
        req = py_pb2.Request(content='hihi')
        msg = get_info(stub, req).content
        print('(result is good)')
        print(msg)


if __name__ == '__main__':
    main()
