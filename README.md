
A simple vagrant setup for running the bionet.


# setup

```
sudo apt install vagrant # or whatever the command is for your distro
git clone https://github.com/biobricks/bionet-vagrant
cd bionet-vagrant/
vagrant up
```

## gotchas

Make sure you have version v20160921.0.0 or higher of the ubuntu/xenial64 vagrant box.

# usage

To start the bionet app:

```
vagrant ssh
cd bionet-new/
npm run start
```

See [bionet-new](https://github.com/biobricks/bionet-new) readme for how to use the bionet server.
