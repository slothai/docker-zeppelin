# vim:set ft=dockerfile:
FROM openjdk:8-jdk-alpine3.8

# Metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF

ARG ZEPPELIN_VERSION=0.8.0
ENV ZEPPELIN_VERSION=${ZEPPELIN_VERSION}

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="Zeppelin" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/slothai/docker-zeppelin" \
    org.label-schema.vendor="SlothAI <https://slothai.github.io/>" \
    org.label-schema.schema-version="1.0"

RUN wget -O source.tar.gz "http://www-us.apache.org/dist/zeppelin/zeppelin-$ZEPPELIN_VERSION/zeppelin-$ZEPPELIN_VERSION-bin-netinst.tgz" && tar xzf source.tar.gz && rm -f source.tar.gz
RUN apk add --no-cache python3
RUN apk add --no-cache --virtual .meta-build-dependencies bash
RUN cd /zeppelin-$ZEPPELIN_VERSION-bin-netinst && \
    cp ./conf/zeppelin-env.sh.template ./conf/zeppelin-env.sh && \
    sed -i -e 's/# export PYSPARK_PYTHON/export PYSPARK_PYTHON=python3/g' -e 's/# export PYTHONPATH/export PYTHONPATH=python3/g' ./conf/zeppelin-env.sh
COPY conf/interpreter.json /zeppelin-$ZEPPELIN_VERSION-bin-netinst/conf/

WORKDIR /zeppelin-$ZEPPELIN_VERSION-bin-netinst
