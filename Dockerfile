#
# Quantum Espresso : a program for electronic structure calculations
#
#
# For many reasons we need to fix the ubuntu release:
FROM ubuntu:16.04

MAINTAINER roberto innocente <inno@sissa.it>
#
# we replace the standard http://archive.ubuntu.com repository
# that is very slow, with the new mirror method :
#     deb mirror://mirrors.ubuntu.com/mirrors.txt ...
ADD  http://people.sissa.it/~inno/qe/sources.list /etc/apt/
#
# we create the user 'qe' and add it to the list of sudoers
RUN  adduser -q --disabled-password --gecos qe qe
RUN  echo "qe 	ALL=(ALL:ALL) ALL" >>/etc/sudoers
#
# we can't change PATH, 'cause .bashrc will not be run
# when entering through docker
#
# we move to /home/qe
WORKDIR /home/qe
#
# we copy the 'qe' files and the needed shared libraries to /home/qe.
# then we unpack them : the 'qe' directly there, the shared libs
# from /
ADD http://people.sissa.it/~inno/qe/qe.tgz http://people.sissa.it/~inno/qe/sl-02.tgz /home/qe/
#
RUN    tar xvzf qe.tgz && tar xvzf sl-02.tgz -C /
#
# we remove the archives we copied
RUN  rm qe.tgz sl-02.tgz 
#
#
# we chown -R files in /home/qe, make pw.x executable, set 'qe' passwd
RUN chown -R qe:qe /home/qe \
    && chmod a+x pw.x \
    && (echo "root:mammamia"|chpasswd)


CMD [ "/bin/bash" ]

