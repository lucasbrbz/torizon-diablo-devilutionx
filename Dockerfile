# BUILD ------------------------------------------------------------------------
FROM torizon/cross-toolchain-arm64-imx8:4 AS build

RUN dpkg --add-architecture arm64

RUN apt-get -q -y update && \
    apt-get -q -y install --no-install-recommends \
    cmake \
    libsdl2-dev \
    libsodium-dev \
    libpng-dev libbz2-dev \
    libgtest-dev \
    libgmock-dev \
    libbenchmark-dev \
    libsdl2-image-dev \
    libfmt-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY DevilutionX/ .

# Compile using the cross-compiler provided by the base image
RUN CC=aarch64-linux-gnu-gcc cmake -S. -B build-torizon -DCMAKE_BUILD_TYPE=Release
RUN cmake --build build-torizon -j$(nproc)

# DEPLOY -----------------------------------------------------------------------
FROM torizon/wayland-base-imx8:4 AS deploy

RUN apt-get update && apt-get install -y --no-install-recommends \
    imx-gpu-viv-wayland \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libxkbcommon0 \
    libdrm2 \
    libsdl2-2.0-0 \
    libsdl2-image-2.0-0 \
    libsodium23 \
    libfmt9 \
    libbz2-1.0 \
    libopus0 \
    libopusfile0 \
    libvorbis0a \
    libvorbisfile3 \
    libogg0 \
    libfreetype6 \
    zlib1g \
    libpng16-16 \
    libbrotli1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/devilutionx

# Copy the game assets
COPY spawn.mpq /opt/devilutionx/

# Copy the DevilutionX runtime produced by CMake
COPY --from=build /app/build-torizon/ /opt/devilutionx/

ENTRYPOINT ["/opt/devilutionx/devilutionx"]
