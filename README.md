# baseimage [![Actions](https://github.com/w0rng/baseimage/workflows/build/badge.svg)](https://github.com/w0rng/baseimage/actions)

_персональные docker images_

## python.alpine

Images `w0rng/baseimage:python-latest` и `ghcr.io/w0rng/baseimage/python:latest`

* `pip` заменен на `uv` (вы этого не заметите)
* установлен `bash` и `curl`
* Добавляет приложение пользователя (uid=1001).
* Опционально запускает `/app/init.sh`, если это предусмотрено пользовательским контейнером.
* Добавляет `app` пользователя (uid=1001).
* добавлена минималистичная система инициализации [dumb-init](https://github.com/Yelp/dumb-init/)

### Настройки
Во время выполнения можно указать следующие переменные:
* `VIRTUAL_ENV` - дирректория виртуального окружения, по умолчанию `/venv`
* `APP_UID` - UID внутреннего пользователя приложения, по умолчанию 1001
* `TIME_ZONE` - таймзона контейнера, по умолчанию "Europe/Moscow"

## License

This project includes work from the following project(s) licensed under the MIT License:

- [umputun/baseimage](https://github.com/umputun/baseimage/tree/master)

The original license is included in the LICENSE file.