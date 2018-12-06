# Docker file for Salary_vs_College
# Alexander Pak, Constantin Shuster, Linyang Yu
# December 6, 2018

# Use rocker/tidyverse as the base image
FROM rocker/tidyverse

RUN export DEBIAN_FRONTEND=noninteractive; apt-get -y update \
 && apt-get install -y gdal-bin \
    libgdal-dev \
    libproj-dev

# ggalt has more dependencies
#RUN installGithub.r rundel/libproj \
#&& rm -rf /tmp/downloaded_packages/

# ggalt has dependencies
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    proj4

# Install `here` package 
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    here

# Install `ggalt` package to create dumbbell plots
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    ggalt

# Install `scales` package to properly form plots
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    scales
