#!/bin/bash

export GOPATH=${PREFIX}/gopath
mkdir -p ${GOPATH}

DVID_REPO=${GOPATH}/src/github.com/janelia-flyem/dvid
mkdir -p $(dirname ${DVID_REPO})

cp -r ${SRC_DIR} ${DVID_REPO}
cd ${DVID_REPO}

# gopackages
go get -u github.com/janelia-flyem/go
cd ${GOPATH}/src/github.com/janelia-flyem/go
git submodule init
git submodule update
cd -

# gojsonschema
go get github.com/janelia-flyem/gojsonschema

# goji
go get github.com/zenazn/goji

# msgp
#go get github.com/tinylib/msgp

go get golang.org/x/net/context

# lumberjack
go get gopkg.in/natefinch/lumberjack.v2

# snappy
go get github.com/golang/snappy

# groupcache
go get github.com/golang/groupcache

# oauth2
go get golang.org/x/oauth2
go get cloud.google.com/go/compute/metadata

# gcloud
go get cloud.google.com/go/bigtable
go get cloud.google.com/go/storage
go get google.golang.org/api/option
go get google.golang.org/grpc
go get github.com/golang/protobuf/proto
go get github.com/golang/protobuf/protoc-gen-go

# gorpc
go get github.com/valyala/gorpc

# protobuf
go get github.com/gogo/protobuf/proto
go get github.com/gogo/protobuf/gogoproto
go get github.com/gogo/protobuf/protoc-gen-gogoslick

# nrsc
#go build -o ${BUILDEM_BIN_DIR}/nrsc

# gofuse
go get bazil.org/fuse

# gobolt
go get github.com/boltdb/bolt

# gomdb
go get github.com/DocSavage/gomdb

DVID_BACKEND="basholeveldb;gbucket"

# dvid-gen-version
go build -o ${PREFIX}/bin/dvid-gen-version -v -tags "${DVID_BACKEND}" cmd/gen-version/main.go 
${PREFIX}/bin/dvid-gen-version -o ${DVID_REPO}/server/version.go

# Build DVID
go build -o ${PREFIX}/bin/dvid -v -tags "${DVID_BACKEND}" ${DVID_REPO}/cmd/dvid/main.go
