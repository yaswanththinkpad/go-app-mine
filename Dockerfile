FROM golang:1.22.5  as master

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

##Final Stage 

FROM gcr.io/distroless/base

COPY --from=stage /app/main .

COPY --from=stage /app/static ./static

EXPOSE 8080

CMD [ "./main" ]