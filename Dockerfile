FROM i386/debian:12-slim
LABEL maintainer="Ch0wW@baseq.fr"

# Create user
RUN groupadd -r q3dc
RUN useradd --no-log-init --system --create-home --home-dir /server --gid q3dc q3dc
USER q3dc

# Run Quake 3 DC Required files
RUN mkdir /server/q3a
WORKDIR /server/q3a

COPY install/quake3dc.tar.gz ./
RUN tar -xzf quake3dc.tar.gz

# Copy configurations required for Q3A
RUN chmod +x q3ded

# Delete the image's baseq3 folder... Since we link it outside.
RUN rm -rf /server/q3a/baseq3

# Default port is 27960 UDP. Expose it.
EXPOSE 27960/udp

ENV TERM xterm

ENTRYPOINT ["./q3ded", "+set dedicated 2"]
CMD ["+exec config/ffa.cfg", "+map dc_map02"]