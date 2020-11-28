# Server Factory Utils

Various utils for [Server Factory](https://github.com/milos85vasic/Server-Factory).

## SSH login without password

To enable SSH login without a password use `init_ssh_access.sh` script. 
Script will generate SSH key and incorporate it into the remote machine.


### How to use `init_ssh_access.sh` script

Script is accepting two parameters: 

- the remote host that into which we will incorporate SSH key for access
- port for SSH access on the remote server (this parameter is optional).

Example of use:

```
sh init_ssh_access.sh centos8.dev.local
```

or

```
sh init_ssh_access.sh 192.168.0.101
```

Once script has been executed with success you can access the remote server as a root without providing the password:

```
ssh centos8.dev.local
```

or

```
ssh root@192.168.0.101
```

## Tunneling

To create a tunnel between your machine and remote machine service you can use `tunnel.sh` script.

### How to use `tunnel.sh` script

Script accepts two parameters:

- Port to use on localhost side (will be tunneled to the same port on remote side)
- Remote host

Example of use:

```
sh tunnel.sh 35432 centos8.dev.local
```

or

```
sh tunnel.sh 35432 root@192.168.0.101
```

Now we are able to access this service locally on port 35432:

```
telnet 127.0.0.1 35432
```


