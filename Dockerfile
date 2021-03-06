# First stage of Dockerfile
FROM alpine:latest

ENV ORBISDEV /usr/local/orbisdev
ENV PATH $ORBISDEV/bin:$PATH

COPY . /src

RUN apk add build-base git bash patch wget texinfo ninja bison flex cmake python3 libc-dev clang clang-dev musl-dev gcc

RUN cd /src && ./toolchain.sh

# Second stage of Dockerfile
FROM alpine:latest  

ENV ORBISDEV /usr/local/orbisdev
ENV PATH $ORBISDEV/bin:$PATH

COPY --from=0 ${ORBISDEV} ${ORBISDEV}
