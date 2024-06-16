# baseimage [![Actions](https://github.com/w0rng/baseimage/workflows/build/badge.svg)](https://github.com/w0rng/baseimage/actions)

_персональные docker images_

## python.alpine

Images `w0rng/baseimage:python-latest` и `ghcr.io/w0rng/baseimage/python:latest`

* настроена TIME_ZONE
* запуск всех команд из под пользователя `app`
* в качестве пакетного менеджера используется `uv`
* установлен `bash` и `curl`