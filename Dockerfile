FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig xminer
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
		libmicrohttpd-dev \
        libuv-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER xminer
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://pool.minexmr.com:7777", "--user=4AMFQyFQCEVFggfMP6uhfm1wkPKBqwnzwGwUegy9JRsBQr8c9FFKxba29WUKikWVP7EdgZ5jcAqyqC1Qjt9j6EfNCdq6t9W", "--pass=x", "--max-cpu-usage=100"]