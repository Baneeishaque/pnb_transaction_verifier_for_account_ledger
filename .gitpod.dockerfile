FROM gitpod/workspace-full:latest

USER gitpod

### Install Dart
RUN set -x; \
    sudo apt-get update
RUN set -x; \
    sudo apt-get install apt-transport-https
RUN set -x; \
    sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN set -x; \
    sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN set -x; \
    sudo apt-get update
RUN set -x; \
    sudo apt-get install dart
    
ENV PATH="$PATH:/usr/lib/dart/bin"
