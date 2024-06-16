FROM python:3.12-alpine3.20

LABEL org.opencontainers.image.authors="w0rng <me@w0rng.ru>"

ENV TIME_ZONE=Europe/Moscow     \
    VIRTUAL_ENV=/home/app/.venv \
    TERM=xterm-color            \
    PATH="/home/app/.local/bin:/home/app/.venv/bin:$PATH"

RUN apk add --no-cache --update curl bash && \
    echo "${TIME_ZONE}" > /etc/timezone && \
    cp /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    date && \
    addgroup -g 2000 app && \
    adduser -u 2000 -G app -s /bin/bash -D app && \
    rm -rf /var/cache/apk/*

USER app

RUN pip install --upgrade --no-cache-dir pip setuptools uv && \
    uv venv /home/app/.venv && \
    echo 'alias pip="uv pip"' >> ~/.bashrc
