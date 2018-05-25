#!/bin/bash

set -e

APP_DIR=$(readlink -f --canonicalize $(eval echo $APP_DIR))

cd $APP_DIR
virtualenv -p /usr/bin/python3 .
. bin/activate \
    && cd src \
    && git clone https://github.com/phlax/ctrl.core \
    && git clone https://github.com/phlax/ctrl.config \
    && git clone https://github.com/phlax/ctrl.command \
    && git clone https://github.com/phlax/ctrl.systemd \
    && cd ctrl.core \
    && pip install -e . \
    && cd ../ctrl.command \
    && pip install -e . \
    && cd ../ctrl.config \
    && pip install -e . \
    && cd ../ctrl.systemd \
    && pip install -e .
