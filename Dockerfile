ARG ALPINE_VERSION="3.14"
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache s6-overlay shadow

# https://git.io/JnEnY
ARG S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=${S6_BEHAVIOUR_IF_STAGE2_FAILS}
ARG S6_CMD_WAIT_FOR_SERVICES_MAXTIME=15000
ENV S6_CMD_WAIT_FOR_SERVICES_MAXTIME=${S6_CMD_WAIT_FOR_SERVICES_MAXTIME}

ARG __USER="_owner"
ENV __USER=${__USER}

# http://www.skarnet.org/software/execline/dieshdiedie.html
SHELL ["execlineb", "-P", "-c"]

RUN importas -iu __USER __USER \
	useradd -MU -d /dev/null -s /sbin/nologin ${__USER}

COPY overlay-rootfs /

CMD ["/init"]
