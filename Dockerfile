FROM debian:buster-slim

RUN apt update && apt install -y g++ gcc make cmake git && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/google/flatbuffers.git \
    && ( cd flatbuffers \
    && cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release \
    && make \
    && ./flattests)

FROM debian:buster-slim
COPY --from=0 /flatbuffers/flatc  /usr/bin
RUN mkdir -p /work
WORKDIR /work