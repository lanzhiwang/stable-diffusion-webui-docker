FROM --platform=$TARGETPLATFORM nvidia/cuda:11.4.1-devel-ubuntu20.04

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.version=$BUILD_VERSION

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libbluetooth-dev \
		tk-dev \
		uuid-dev \
        wget \
        git \
	; \
	rm -rf /var/lib/apt/lists/*

# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh
# RUN bash ./Miniconda3-latest-Linux-$(uname -m).sh -b

# RUN conda install python="3.10" -y

WORKDIR /app/

RUN git clone https://github.com/lanzhiwang/stable-diffusion-webui.git /app/stable-diffusion-webui

WORKDIR /app/stable-diffusion-webui

RUN bash ./webui.sh --skip-torch-cuda-test || exit 0 && git status