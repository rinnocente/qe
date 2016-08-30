#
# Quantum Espresso : a program for electronic structure calculations
#    
# For many reasons we need to fix the ubuntu release:
FROM ubuntu:16.04
#
MAINTAINER roberto innocente <inno@sissa.it>
#
# The ARG directive is a new dockerfile directive (https://github.com/docker/docker/issues/14634).
# It permits to define, differently from ENV, variables to be used only during the build and not in operations.
# If it is not supported by your docker version then the "DEBIAN_FRONTEND=noninteractive" definition
# should be placed in front of every apt install to silence the scaring warning messages
# apt  would produce
#
ARG DEBIAN_FRONTEND=noninteractive
#
#
# we replace the standard http://archive.ubuntu.com repository
# that is very slow, with the new mirror method :
# deb mirror://mirror.ubuntu.com/mirrors.txt ...
ADD  http://people.sissa.it/~inno/qe/sources.list /etc/apt/
#
#
WORKDIR /root 
#
# dl shared libs at their places
ADD  http://people.sissa.it/~inno/qe/sl-03.tgz .
RUN  tar xzf sl-03.tgz -C / \
     && rm sl-03.tgz
# we prepare a bin subdir where to store
# espresso binaries and dlmenu
RUN mkdir bin
#
# dl pw.x and input files in /root
RUN  wget http://people.sissa.it/~inno/qe/qe.tgz  \
          http://people.sissa.it/~inno/qe/bin/dlmenu   \
	&& chmod a+x dlmenu && mv dlmenu ./bin/
#
# download pw.x and input files in homedir /root
RUN  tar xvzf qe.tgz   \
	&& rm qe.tgz

# we need to add ./bin to the PATH
RUN echo "PATH=/root/bin:${PATH}" >>.bashrc
ENV BASH_ENV .bashrc
#
CMD [ "/bin/bash" ]
