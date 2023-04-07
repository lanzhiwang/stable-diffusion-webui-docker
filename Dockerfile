FROM --platform=$TARGETPLATFORM jupyter/minimal-notebook:python-3.10.10

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.version=$BUILD_VERSION

WORKDIR /app/

RUN git clone https://github.com/lanzhiwang/stable-diffusion-webui.git /app/stable-diffusion-webui

WORKDIR /app/stable-diffusion-webui

RUN bash ./webui.sh --skip-torch-cuda-test || exit 0 && git status
