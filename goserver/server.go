package main

import (
	"context"
	"fmt"
	"google.golang.org/grpc"
	"log"
	"net"
	"samuel.com/pbinfo"
)

var rtn_msg string = "haha"
var addr string = "127.0.0.1:8081"

type service struct {
	pbinfo.UnimplementedExampleServiceServer
}

func (s *service) GetInfo(ctx context.Context, in *pbinfo.Request) (*pbinfo.Response, error) {
	log.Printf("Received: %v", in.Content)
	return &pbinfo.Response{Content: rtn_msg}, nil
}

func main() {
	fmt.Println("hello world")
	fmt.Println("return message: ", rtn_msg)

	lis, err := net.Listen("tcp", addr)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	log.Println("Server listening on", addr)
	gRPCServer := grpc.NewServer()
	pbinfo.RegisterExampleServiceServer(gRPCServer, &service{})
	if err := gRPCServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}