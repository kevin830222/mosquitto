FROM ubuntu
MAINTAINER kkshyu <kevin830222@gmail.com>

# Upgrade apt
RUN apt-get update && apt-get install -y software-properties-common

# Add repository
RUN apt-add-repository -y ppa:mosquitto-dev/mosquitto-ppa && apt-get update

# Install libraries
RUN apt-get install -y mosquitto supervisor && \
    apt-get clean all

# Make directories in need
RUN mkdir -p /supervisor /mosquitto

# Update supervisor conf
COPY mosquitto /mosquitto
COPY supervisor /supervisor

VOLUME ["/supervisor", "/mosquitto"]

# Expose port
EXPOSE 1883 9001 9487

# Default command
CMD ["/usr/bin/supervisord", "-n", "-c", "/supervisor/supervisord.conf"]
