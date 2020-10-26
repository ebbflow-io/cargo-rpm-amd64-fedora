FROM fedora:32

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH;

RUN set -eux; \
    dnf -y install musl-devel openssl-devel; \
    dnf -y groupinstall 'Development Tools'; \
	curl -o /tmp/install_rust.sh https://sh.rustup.rs; \
	sh /tmp/install_rust.sh -y --default-toolchain 1.47.0;

RUN dnf -y install musl-gcc
RUN dnf -y install rpm-build
RUN dnf -y install systemd-rpm-macros
ENV CC=musl-gcc \
    PREFIX=/musl \
    PATH=/usr/local/bin:/root/.cargo/bin:$PATH \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    LD_LIBRARY_PATH=$PREFIX

RUN set -eux; \
    rustup target add x86_64-unknown-linux-musl; \
    cargo install cargo-rpm;

ENV CARGO_BUILD_TARGET=x86_64-unknown-linux-musl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
