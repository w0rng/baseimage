FROM python:3.12-slim

LABEL org.opencontainers.image.authors="w0rng <me@w0rng.ru>"
LABEL org.opencontainers.image.source="https://github.com/w0rng/baseimage/"

ENV TIME_ZONE=Europe/Moscow     \
    VIRTUAL_ENV=/venv           \
    TERM=xterm-color            \
    APP_USER=app                \
    APP_UID=1001

COPY ./init.sh /init.sh
COPY ./pip.sh /pip

RUN chmod +x /init.sh /pip && \
    apt update && apt --no-install-recommends install -y dumb-init curl && rm -rf /var/lib/apt/lists/* &&  \
    mkdir -p /home/$APP_USER && \
    adduser --shell /bin/bash --uid $APP_UID $APP_USER && chown -R $APP_USER:$APP_USER /home/$APP_USER && \
    ln -s /usr/bin/dumb-init /sbin/dinit && \
    mkdir -p /app && chown -R $APP_USER:$APP_USER /app && \
    pip install --upgrade --no-cache-dir pip setuptools uv && \
    mkdir -p ${VIRTUAL_ENV} && chown -R $APP_USER:$APP_USER ${VIRTUAL_ENV} && \
    python -c "import compileall; compileall.compile_path(maxlevels=10)" && \
    uv venv ${VIRTUAL_ENV} && \
    rm /usr/local/bin/pip && \
    mv /pip /usr/local/bin/pip

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR /app

ENTRYPOINT ["/init.sh"]
CMD ["python"]
