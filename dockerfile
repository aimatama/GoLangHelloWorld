FROM golang:1.8-alpine as builder

RUN mkdir /build 

ADD . /build/

WORKDIR /build 

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o helloworld .

FROM scratch

COPY --from=builder /build/helloworld /app/

WORKDIR /app

CMD ["./helloworld"]