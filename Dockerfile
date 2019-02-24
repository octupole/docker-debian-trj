# ------------------------------------------------------------------------------
# build stage
# Uses https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.0.tar.bz2
# ------------------------------------------------------------------------------

FROM octupole/debian-opentrj as base-opentrj
FROM debian:stretch

COPY --from=base-opentrj /usr/local /usr/local

ENV CPU=1
RUN apt-get update && apt-get install openssh-server fftw3 -y && mkdir -p /app/bin && echo "#!/bin/sh" > /app/bin/mpirun.sh \
    && echo "mpirun --allow-run-as-root -mca btl_base_warn_component_unused 0 -np \${CPU} \$@ " >> /app/bin/mpirun.sh \
    && chmod 755 /app/bin/mpirun.sh && cat /app/bin/mpirun.sh

VOLUME /work
WORKDIR /work
ENTRYPOINT ["/app/bin/mpirun.sh"]
