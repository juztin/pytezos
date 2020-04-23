# PyTezos
#
# v2.4.5
#

FROM python:3-alpine

RUN apk update \
	&& apk --no-cache add --virtual \
		build-deps \
		build-base \
		autoconf \
		automake \
		git \
		gmp-dev \
		isl \
		libatomic \
		libffi-dev \
		libgomp \
		libressl-dev \
		libtool \
		make \
		mpfr4 \
		mpc1 \
		musl-dev \
		openssl \
	&& apk --no-cache add \
		binutils \
		libsodium-dev \
	&& cd ~ && git clone https://github.com/bitcoin-core/secp256k1.git && cd secp256k1 \
	&& ./autogen.sh \
	&& ./configure \
	&& make install \
	&& cd .. && rm -rf secp256k1/ \
	&& pip3 install poetry==1.0.5 \
	&& pip3 install --no-build-isolation pendulum==2.1.0 \
	&& pip3 install pytezos==2.4.5 \
	&& pip3 uninstall --yes poetry \
	&& apk del build-deps
