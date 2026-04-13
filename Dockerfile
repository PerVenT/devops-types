# ==========================================
# Stage 1: Builder
# ==========================================
FROM golang AS builder

WORKDIR /src

COPY ./src .

RUN go mod init devops-types && \
    CGO_ENABLED=0 go build -o app

# ==========================================
# Stage 2: Final
# ==========================================
FROM scratch

# RUN addgroup -S webserver && \
#     adduser -S webserver -G webserver

WORKDIR /

ADD ./html /html

COPY --from=builder /src/app /

ENTRYPOINT ["/app"]

# USER webserver

EXPOSE 8080




