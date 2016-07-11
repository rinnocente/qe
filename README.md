# qe
Dockerfile for a QuantumEspresso container accessible from docker.

*(The resulting image is based on ubuntu:16.04 and its size is around ~170 MB)*

**Quantum Espresso** is a widely used package for electronic structure calculations.

Further information is  available on its website : [www.quantum-espresso.org](http://www.quantum-espresso.org/).

This Dockerfile builds a container for **QE** that is accessible through docker.

The image [rinnocente/qe](https://hub.docker.com/r/rinnocente/qe/) on dockerhub.com is created from this Dockerfile using :
```
  $ docker build -t qe .
```
You can run the container in background  with :
```
  $ CONT_ID=`docker run -d -it qe`
```
We can access the container attaching of the host on which the container ssh service is mapped :
```
  $ PORT=`docker port $CONT_ID 22|sed -e 's#.*:##'`
  $ ssh -p $PORT qe@127.0.0.1
```
the initial password for the 'qe' user is 'mammamia', don't forget to change it immediately.

The **QE** container has the QuantumEspresso executable (**pw.x**) , an input test file (**relax.in**)
and 2 pseudopotential files necessary to run the test (**C.pz-rrkjus.UPF** and **O.pz-rrkjus.UPF**) inside
the 'qe' home directory.

When you are inside the container you can run the test typing simply :
```
  $ ./pw.x <relax.in
```

The normal way in which you use this container is sharing an input-output directory between your host 
and the container. In this case you create a subdir in your host :
```
  $ mkdir ~/qe-in-out
```
and when you run the container you share this directory  with the container as a volume :
```
 $ CONT_ID=`docker run -v ~/qe-in-out:/home/qe/qe-in-out -d -it qe-ssh`
 $ PORT=`docker port $CONT_ID|sed -e 's#.*:##'`
```
### NB. this container can be reached via ssh through **your host port $PORT** eventually from the Internet at large.

![qe](http://www.quantum-espresso.org/wp-content/uploads/2011/12/Quantum_espresso_logo.jpg)

