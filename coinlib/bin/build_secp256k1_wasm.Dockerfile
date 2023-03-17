FROM debian:bullseye

# Install dependenices
RUN apt-get update -y \
  && apt-get install -y autoconf libtool build-essential git wget

# Download and install wasi-sdk

ENV WASI_VERSION=19
ENV WASI_VERSION_FULL=${WASI_VERSION}.0
ENV WASI_SDK_PATH=/wasi-sdk-${WASI_VERSION_FULL}
ENV WASI_ARCHIVE=wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz

RUN wget -nv https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/$WASI_ARCHIVE
RUN tar xvf $WASI_ARCHIVE
RUN rm $WASI_ARCHIVE

# Clone libsecp256k1
RUN git clone https://github.com/bitcoin-core/secp256k1
WORKDIR /secp256k1

# Use 0.2.0 release
RUN git checkout 21ffe4b22a9683cf24ae0763359e401d1284cc7a

# Build using wasi-sdk
RUN ./autogen.sh
RUN ./configure \
  --enable-module-recovery --disable-tests --disable-shared \
  --disable-exhaustive-tests --disable-benchmark \
  --with-sysroot=${WASI_SDK_PATH}/share/wasi-sysroot \
  --host=wasm32 --target=wasm32-unknown-wasi \
  CFLAGS="-O2 -fPIC" CC=${WASI_SDK_PATH}/bin/clang
RUN make

# Link output with wasi standard library and export required functions
RUN mkdir output
RUN ${WASI_SDK_PATH}/bin/wasm-ld \
  -o output/secp256k1.wasm \
  --no-entry \
  --export malloc \
  --export free \
  --export secp256k1_context_create \
  --export secp256k1_context_randomize \
  --export secp256k1_ec_pubkey_create \
  --export secp256k1_ec_pubkey_serialize \
  # The secp256k1 library object files
  src/libsecp256k1_la-secp256k1.o \
  src/libsecp256k1_precomputed_la-precomputed_ecmult.o \
  src/libsecp256k1_precomputed_la-precomputed_ecmult_gen.o \
  # Need to include libc for wasi here as it isn't done for us
  ${WASI_SDK_PATH}/share/wasi-sysroot/lib/wasm32-wasi/libc.a \
  # Need to include another library from clang that isn't included either
  # See https://github.com/WebAssembly/wasi-libc/issues/98
  ${WASI_SDK_PATH}/lib/clang/15.0.7/lib/wasi/libclang_rt.builtins-wasm32.a