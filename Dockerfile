FROM ubuntu:20.04

MAINTAINER Max Schrader (mcschrader@crimson.ua.edu)
LABEL Description="Dockerised Simulation of Urban MObility(SUMO)"

ENV SUMO_HOME /opt/sumo
ENV SUMO_USER mcschrader

# Install system dependencies.
RUN apt-get update && apt-get -qq install \
    wget \
    g++ \
    make \
    libxerces-c-dev \
    libfox-1.6-0 libfox-1.6-dev \
    python2.7 \
    python3.9

# Download and extract source code
RUN git clone git@github.com:UnivOfAlabama-BittleResearchGroup/sumo.git && cd sumo
RUN export SUMO_HOME=$pwd
RUN mkdir build/cmake-build && cd build/cmake-build
RUN cmake ../.. && make -j$(nproc)

RUN adduser $SUMO_USER --disabled-password
# CMD sumo-gui
