#!/sbin/dinit /bin/sh

uid=$(id -u)

if [[ ${uid} -eq 0 ]]; then
    echo "init container"

    # set container's time zone
    cp /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
    echo "${TIME_ZONE}" >/etc/timezone
    echo "set timezone ${TIME_ZONE} ($(date))"

    # set UID for user app
    if [[ "${APP_UID}" -ne "1001" ]]; then
        echo "set custom APP_UID=${APP_UID}"
        sed -i "s/:1001:1001:/:${APP_UID}:${APP_UID}:/g" /etc/passwd
    else
        echo "custom APP_UID not defined, using default uid=1001"
    fi
    chown -R app:app /app /home/app /venv
fi


if [[ -f "/app/init.sh" ]]; then
    echo "execute /app/init.sh"
    chmod +x /app/init.sh
    /app/init.sh
    if [[ "$?" -ne "0" ]]; then
      echo "/app/init.sh failed"
      exit 1
    fi
else
    echo "/app/init.sh not found, starting without it"
fi

echo execute "$@"
if [[ ${uid} -eq 0 ]]; then
   exec su-exec app "$@"
else
   exec "$@"
fi