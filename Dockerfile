FROM golang:1.9-alpine

ENV GOOS linux
ENV GOARCH 386

RUN apk --update --no-cache add git \
    && go get -u github.com/golang/dep/...

WORKDIR /go/src/app

COPY src/ ./
RUN ls $GOPATH/bin/linux_386/dep
RUN $GOPATH/bin/linux_386/dep init && $GOPATH/bin/linux_386/dep ensure -update
RUN go build -o ./app ./main.go
RUN ls /go/src/app


FROM scratch

WORKDIR /root/

COPY --from=0 /go/src/app/app .

EXPOSE 8080

CMD ["./app"]