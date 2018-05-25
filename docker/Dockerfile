# phlax/zmq
#
# VERSION       0.0.1

ARG BUILD_FROM=debian:stretch-slim

# Root stage shared by builder and app images
FROM $BUILD_FROM as root

MAINTAINER Ryan Northey <ryan@synca.io>
ENV DEBIAN_FRONTEND=noninteractive


ARG APP_USER_ID=1000
ARG APP_GROUP_ID=1000
ARG APP_USERNAME=app
ARG APP_DIR=/app


ENV DEBIAN_FRONTEND=noninteractive \
    APP_DIR=$APP_DIR \
    APP_USERNAME=$APP_USERNAME \
    APP_DEBS="dbus \
       locales \
       policykit-1 \
       python3-minimal \
       systemd \
       virtualenv"

COPY ./install /tmp/install
RUN /tmp/install/install.sh

# Build stage
FROM root as builder

ENV APP_BUILD_DEBS="build-essential \
        git \
        libsystemd-dev \
        pkg-config \
        python3-dev"


COPY ./builder /tmp/build
RUN /tmp/build/build.sh
RUN su app /tmp/build/build-user.sh

# App stage
FROM root

ENV PYTHONPATH=/app/src \
    APP_SERVER=

#COPY ./app /tmp/app
#RUN /tmp/app/create.sh

# the chown flag has to be hardcoded for now
COPY --chown=app:app --from=builder "$APP_DIR" "$APP_DIR"

RUN cd /lib/systemd/system/sysinit.target.wants/; ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
    rm -rf /lib/systemd/system/multi-user.target.wants/*;\
    rm -rf /etc/systemd/system/*.wants/*;\
    rm -rf /lib/systemd/system/local-fs.target.wants/*; \
    rm -rf /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -rf /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -rf /lib/systemd/system/basic.target.wants/*;\
    rm -rf /lib/systemd/system/anaconda.target.wants/*; \
    rm -rf /lib/systemd/system/plymouth*; \
    rm -rf /lib/systemd/system/systemd-update-utmp*;

RUN systemctl set-default multi-user.target

STOPSIGNAL 37
VOLUME [ "/sys/fs/cgroup" ]
ENTRYPOINT ["/lib/systemd/systemd"]
