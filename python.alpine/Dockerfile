FROM python:3.12-alpine3.20

LABEL org.opencontainers.image.authors="w0rng <me@w0rng.ru>"
LABEL org.opencontainers.image.source="https://github.com/w0rng/baseimage/"

ENV TIME_ZONE=Europe/Moscow     \
    VIRTUAL_ENV=/home/app/.venv \
    TERM=xterm-color            \
    APP_USER=app                \
    APP_UID=1001                \
    DOCKER_GID=999

COPY ./init.sh /init.sh
COPY ./pip.sh /pip

RUN chmod +x /init.sh /pip && \
    echo "https://mirror.yandex.ru/mirrors/alpine/v3.20/main/" > /etc/apk/repositories && \
    echo "https://mirror.yandex.ru/mirrors/alpine/v3.20/community/" >> /etc/apk/repositories && \
    apk add --no-cache --update su-exec curl dumb-init && \
    ln -s /sbin/su-exec /usr/local/bin/gosu && \
    mkdir -p /home/$APP_USER && \
    adduser -s /bin/sh -D -u $APP_UID $APP_USER && chown -R $APP_USER:$APP_USER /home/$APP_USER && \
    delgroup ping && addgroup -g 998 ping && \
    addgroup -g ${DOCKER_GID} docker && addgroup ${APP_USER} docker && \
    mkdir -p /srv && chown -R $APP_USER:$APP_USER /srv && \
    cp /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo "${TIME_ZONE}" > /etc/timezone && date && \
    ln -s /usr/bin/dumb-init /sbin/dinit && \
    rm -rf /var/cache/apk/*

RUN pip install --upgrade --no-cache-dir pip setuptools uv && \
    uv venv /home/$APP_USER/.venv && \
    rm /usr/local/bin/pip && \
    mv /pip /usr/local/bin/pip

ENV PATH="/home/$APP_USER/.venv/bin:$PATH"

WORKDIR /home/$APP_USER

ENTRYPOINT ["/init.sh"]
CMD ["python"]