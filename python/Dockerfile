ARG PYTHON_VERSION=3.12

FROM python:${PYTHON_VERSION}-slim

LABEL org.opencontainers.image.authors="w0rng <me@w0rng.ru>"
LABEL org.opencontainers.image.source="https://github.com/w0rng/baseimage/"

ARG APP_USER=app
ARG VIRTUAL_ENV=/venv

ENV TIME_ZONE=Europe/Moscow \
    TERM=xterm-color        \
    APP_UID=1001

COPY --chmod=111 ./init.sh /init.sh
COPY --chmod=111 ./pip.sh /pip


RUN apt update && apt --no-install-recommends install -y dumb-init curl && rm -rf /var/lib/apt/lists/* &&  \
    ln -s /usr/bin/dumb-init /sbin/dinit

RUN adduser --shell /bin/bash --uid $APP_UID $APP_USER --disabled-password --home=/app && \
    mkdir -p ${VIRTUAL_ENV} && chown -R $APP_USER:$APP_USER ${VIRTUAL_ENV}

RUN pip install --upgrade --no-cache-dir pip setuptools uv && \
    uv venv ${VIRTUAL_ENV} && \
    rm /usr/local/bin/pip && \
    mv /pip /usr/local/bin/pip && \
    python -c "import compileall; compileall.compile_path(maxlevels=10, optimize=2)"

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR /app

ENTRYPOINT ["/init.sh"]
CMD ["python"]
