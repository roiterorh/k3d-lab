ARG ALPINE_VERSION=alpine:3.15
ARG K3S_VERSION=v1.24.4-k3s1
FROM $ALPINE_VERSION as base
RUN apk add -U open-iscsi bash

FROM rancher/k3s:$K3S_VERSION
COPY --from=base /bin/bash /bin/bash
COPY --from=base /etc/iscsi /etc/iscsi
COPY --from=base /lib /lib
COPY --from=base /usr/lib /usr/lib
COPY --from=base /usr/sbin/iscsi* /sbin/iscsi* /usr/sbin/