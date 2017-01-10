# qe
Dockerfile for a QuantumEspresso ver 5.4.0  (serial) container.

*(The resulting image is based on ubuntu:16.04 and its size is around ~200 MB)*

**Quantum Espresso** is a widely used package for electronic structure calculations.

Further information is  available on its website : [www.quantum-espresso.org](http://www.quantum-espresso.org/).

This Dockerfile builds a container for **QE** that is accessible through docker.

The image [rinnocente/qe](https://hub.docker.com/r/rinnocente/qe/) on dockerhub.com is created from this Dockerfile using :
```
  $ docker build -t qe .
```
You can run the container in background  with :
```
  $ CONT=`docker run -d -it qe`
```
We can access the container attaching to its PID 1 (that is a bash) :
```
  $ docker attach $CONT
```
if you exit the shell with ```CTRL-D``` or ```exit```  the container will die because its PID 1 exits.

If you want to keep the container active, exit with CTRL-P CTRL-Q (keep down CTRL then press P and then Q).

The **QE** container has the QuantumEspresso executable (**pw.x**) , an input test file (**relax.in**)
and 2 pseudopotential files necessary to run the test (**C.pz-rrkjus.UPF** and **O.pz-rrkjus.UPF**) inside
the root home directory ('/root'). Don't be scared root of the container is not root of 
your host.

When you are inside the container you can run the test simply typing :
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
 $ CONT=`docker run -v ~/qe-in-out:/home/qe/qe-in-out -d -it qe`
 $ docker attach $CONT
```

---


### The remaining binaries of the **QuantumEspresso** suite

The complete set of binaries of the **QuantumEspresso** suite is large.
There are 63 binaries, for an uncompressed total of ~360 MB.
Therefore in the container there is only 1 test binary and 3 input files for a rapid test,
otherwise the image would be over 0.5 GB.
An easy download menu is provided that can
download one binary at a time or all of them (but compressed ~ 130 MB).
As you would expect, because it lives  in a docker container, this program is written in **golang**,
and can be started typing :
```
$ dlmenu
```
Choosing ```a``` will download all binaries in the ```bin``` subdir.
Choosing a number will download the respective binary in the ```bin``` subdir.
Choosing ```q``` wil quit the downloader.



![qe](http://www.quantum-espresso.org/wp-content/uploads/2011/12/Quantum_espresso_logo.jpg)

