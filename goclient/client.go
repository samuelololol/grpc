package main

import (
	"context"
	"fmt"
	"google.golang.org/grpc"
	"log"
	pb "samuel.com/pbinfo"
	"time"
)

const ADDR = "127.0.0.1:8081"

func main () {
    fmt.Println("hello world")
    conn, err := grpc.Dial(ADDR, grpc.WithInsecure(), grpc.WithBlock())
    if err!= nil {
    	log.Fatalf("Cannot connect to gRPC server: %v", err)
	}
	defer conn.Close()

    c := pb.NewExampleServiceClient(conn)
    ctx, cancel := context.WithTimeout(context.Background(), time.Second)
    defer cancel()

    r, err := c.GetInfo(ctx, &pb.Request{Content: "hihi"})

    if err != nil {
    	log.Fatalf("Could not get nonce: %v", err)
	}
	fmt.Println("Response:", r.GetContent())
}
