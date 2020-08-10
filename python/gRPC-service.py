#!/usr/bin/env python
"""
Description:

Date: Aug 05, 2020
Author: samuel
"""""
from concurrent import futures
import sys
import py_pb2
import py_pb2_grpc
import grpc
import time

_ONE_DAY_IN_SECS=60*60*24
_RTN_MSG = None

class ExampleServicer(py_pb2_grpc.exampleServiceServicer):
    def GetInfo(self, request, context):
        rtn_msg = " ".join(sys.argv[1:])
        print("request: {}, response: {}".format(request.content, rtn_msg))
        return py_pb2.Response(content=rtn_msg)


def main():
    """""Main function"""""
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    py_pb2_grpc.add_exampleServiceServicer_to_server(
            ExampleServicer(), server)
    server.add_insecure_port('[::]:8081')
    server.start()
    print('(service started)')
    print('(always return "{}" to client)'.format(" ".join(sys.argv[1:])))
    try:
        while True:
            time.sleep(_ONE_DAY_IN_SECS)
    except KeyboardInterrupt:
        server.stop(0)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("python gRPC-service.py <messages>")
        sys.exit(1)
    main()
