FROM debian:jessie

# Install dependencies
RUN apt-get update
RUN apt-get -y install wget

# Clean
RUN rm -rf /var/lib/apt/lists/*

# Prepare directories
RUN mkdir /opt/screenconnect-installer

# Volume
VOLUME /volume1/docker/screenconnect:/opt/screenconnect

# Setup
ADD "https://www.screenconnect.com/Download?Action=DownloadLatest&Platform=Linux&PreRelease=false" /opt/screenconnect-installer/ScreenConnect_Release.tar.gz
WORKDIR /opt/screenconnect-installer/
RUN tar xvf ScreenConnect_Release.tar.gz
RUN echo -e "\n\n" | ScreenConnect_*_Install/install.sh

# Ports
EXPOSE 8040 8041

# Command
ADD run.sh /run.sh
WORKDIR /opt/screenconnect
CMD ["/bin/sh", "/run.sh"]
