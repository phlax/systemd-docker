#!/bin/bash

set -e

apt update

apt install -yy -q \
    --no-install-recommends \
    --no-install-suggests \
    $APP_BUILD_DEBS

apt-get clean
