# First stage of Dockerfile
FROM alpine:latest

ENV ORBISDEV /usr/local/orbisdev
ENV PS4TOOLCHAIN $ORBISDEV/toolchain
ENV PATH $ORBISDEV/bin:$PS4TOOLCHAIN/x86_64-pc-freebsd9/bin:$PS4TOOLCHAIN/bin:$PATH

COPY . /src

RUN apk add build-base git bash patch wget texinfo ninja bison flex cmake python3 libc-dev clang clang-dev musl-dev gcc

RUN cd /src && ./toolchain.sh

# Second stage of Dockerfile
FROM alpine:latest  

ENV ORBISDEV /usr/local/orbisdev
ENV PS4TOOLCHAIN $ORBISDEV/toolchain
ENV PATH $ORBISDEV/bin:$PS4TOOLCHAIN/x86_64-pc-freebsd9/bin:$PS4TOOLCHAIN/bin:$PATH

COPY --from=0 ${ORBISDEV} ${ORBISDEV}
