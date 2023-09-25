#
# build container
#
FROM --platform=linux/amd64 golang:1.19-alpine as builder
WORKDIR /

COPY kafka_exporter_linux_amd64 /kafka_exporter_linux_amd64

RUN chmod +x /kafka_exporter_linux_amd64

EXPOSE     9308
ENTRYPOINT [ "/kafka_exporter_linux_amd64" ]
