# ==========================================
# Stage 1: Builder
# ==========================================
FROM ubuntu AS builder

WORKDIR /src

RUN apt-get update && \
    apt-get install -y \
    git nasm build-essential

    RUN git clone https://github.com/den-vasyliev/asmhttpd.git && \
    cd asmhttpd && make

# ==========================================
# Stage 2: Final
# ==========================================
FROM scratch

RUN addgroup -S webserver && \
    adduser -S webserver -G webserver

WORKDIR /html

ADD ./html /html

COPY --from=builder /src/asmhttpd/asmhttpd /

EXPOSE 8080

USER webserver

ENTRYPOINT ["/asmhttpd", "/html"]


