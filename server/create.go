package main

import (
	"context"
	"fmt"
	"log"

	pb "github.com/carlosagil/grpc-blog/proto"

	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (*Server) CreateBlog(ctx context.Context, b *pb.Blog) (*pb.BlogId, error) {
	log.Printf("CreateBlog was invoked with %v\n", b)

	data := BlogPost{
		AuthorID: b.AuthorId,
		Title:    b.Title,
		Content:  b.Content,
	}

	res, err := collection.InsertOne(ctx, data)
	if err != nil {
		return nil, status.Errorf(
			codes.Internal,
			fmt.Sprintf("Internal error: %v", err),
		)
	}

	oid, ok := res.InsertedID.(primitive.ObjectID)
	if !ok {
		return nil, status.Errorf(
			codes.Internal,
			"Cannot convert to OID",
		)
	}

	return &pb.BlogId{
		Id: oid.Hex(),
	}, nil
}
