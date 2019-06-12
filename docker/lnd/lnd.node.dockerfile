FROM golang:1.12.5-stretch

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

#RUN go get -d github.com/lightningnetwork/lnd && \
#  cd /go/src/github.com/lightningnetwork/lnd && \
#  make && make install tags="signrpc walletrpc chainrpc invoicesrpc"

# Copy the binaries and entrypoint from the builder image.
#COPY --from=builder /go/bin/lncli /bin/
#COPY --from=builder /go/bin/lnd /bin/

# Expose lnd ports (server, rpc).
#EXPOSE 9735 10009

# Copy the entrypoint script.
#COPY "./start-lnd.sh" .
#RUN chmod +x start-lnd.sh
