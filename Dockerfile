#
# Quantum Espresso : a program for electronic structure calculations
#    ssh version
#
# For many reasons we need to fix the ubuntu release:
FROM ubuntu:16.04
#
MAINTAINER roberto innocente <inno@sissa.it>
#
#
# we replace the standard http://archive.ubuntu.com repository
# that is very slow, with the new mirror method :
# deb mirror://mirror.ubuntu.com/mirrors.txt ...
ADD  http://people.sissa.it/~inno/qe/sources.list /etc/apt/
#
# we update the package list
# and install wget
RUN apt update \
	&& apt install -y  wget 
#
WORKDIR /root 
# we prepare a bin subdir where to store
# espresso binaries and dlmenu
RUN mkdir bin
#
RUN  wget http://people.sissa.it/~inno/qe/qe.tgz  \
          http://people.sissa.it/~inno/qe/sl-03.tgz \
          http://people.sissa.it/~inno/qe/test-suite.tgz \
          http://people.sissa.it/~inno/qe/bin/dlmenu   \
	&& chmod a+x dlmenu && mv dlmenu ./bin/
#
# download pw.x and input files in homedir /root,
# shared libs at their places
RUN  tar xvzf qe.tgz  \
     &&  tar xvzf sl-03.tgz -C /  


# we need to add ./bin to the PATH
RUN echo "PATH=/root/bin:${PATH}" >>.bashrc
ENV BASH_ENV .bashrc
#
CMD [ "/bin/bash" ]
