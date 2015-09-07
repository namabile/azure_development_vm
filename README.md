#Setting up

## Dependencies
- VirtualBox
- Vagrant
- Chef DK
- Node

## Run this
```$ vagrant plugin install vagrant-azure```
```$ vagrant plugin install vagrant-berkshelf```
```$ vagrant plugin install vagrant-omnibus```
```$ node install -g azure-cli```
```$ azure account download```
```$ azure account import ~/Downloads/*.publishsettings```
```$ azure network vnet create --vnet "dev-network" --location "East US" --create-new-affinity-group```
```$ vagrant box add azure https://github.com/msopentech/vagrant-azure/raw/master/dummy.box```

See [here](https://unindented.org/articles/provision-azure-boxes-with-vagrant/) and [here](https://github.com/Azure/vagrant-azure).
