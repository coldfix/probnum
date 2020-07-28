# Note, let's not use alpine, because it uses musl and not glibc as C standard
# library, and therefore may have subtle difference to most other linuxes,
# see: https://pythonspeed.com/articles/alpine-docker-python/
FROM python:3.8-slim

ENV GITHUB_SECRET ""
ENV GITHUB_TOKEN ""
ENV RUNNER_NAME "mlcloud-0"

RUN apt-get update --yes && \
    apt-get install --yes dumb-init webhook task-spooler git && \
    useradd asv -u 1010 --user-group --create-home && \
    mkdir /benchmarks && \
    install -g asv -o asv -d /benchmarks/runs

USER asv:asv
COPY . /benchmarks
WORKDIR /benchmarks
EXPOSE 5678

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD [ "webhook", "-verbose", "-urlprefix", "", \
      "-hooks", "hooks.yaml", "-template", "-hotreload", \
      "-ip", "0.0.0.0", "-port", "5678" ]
