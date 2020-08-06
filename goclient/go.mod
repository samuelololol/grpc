module samuel.com/goclient

go 1.14

require (
	github.com/golang/protobuf v1.4.2 // indirect
	google.golang.org/grpc v1.31.0
	google.golang.org/protobuf v1.25.0 // indirect
	samuel.com/pbinfo v0.0.0
)

replace samuel.com/pbinfo => ../pbinfo
