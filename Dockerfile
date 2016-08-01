#
# Quantum Espresso : a program for electronic structure calculations
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
