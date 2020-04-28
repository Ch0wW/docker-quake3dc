FROM i386/debian:jessie-slim
MAINTAINER Ch0wW <Ch0wW@baseq.fr>

# 1) INSTALL BASICS
RUN apt-get update && apt-get install -y wget

# 2) Create user
RUN groupadd -r q3dc
RUN useradd --no-log-init --system --create-home --home-dir /server --gid q3dc q3dc
USER q3dc

# 3) Run Quake 3 DC Required files
RUN mkdir /server/q3a
RUN wget -O - https://dl.baseq.fr/quake/q3dc/quake3dc.tar.gz | \
  tar -xzf - -C /server/q3a

WORKDIR /server/q3a

# 4) Copy configurations required for Q3A
RUN chmod +x q3ded
COPY config/* ./baseq3/

EXPOSE 27960
EXPOSE 27960/udp

ENV TERM xterm

ENTRYPOINT ["./q3ded"]
CMD ["+set dedicated 2", "+exec ffa.cfg", "+map dc_map19"]