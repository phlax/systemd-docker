# phlax/zmq
#
# VERSION       0.0.1

ARG BUILD_FROM=debian:buster-slim

FROM $BUILD_FROM

MAINTAINER Ryan Northey <ryan@synca.io>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
    && apt-get install \
	-y \
	-qq \
	--no-install-recommends \
	--no-install-suggests \
	dbus \
	locales \
	policykit-1 \
	systemd \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8

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

COPY start-systemd /usr/local/bin

STOPSIGNAL SIGRTMIN+3
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/local/bin/start-systemd"]
