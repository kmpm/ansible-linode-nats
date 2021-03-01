# Ansible Linode NATS

- https://www.linode.com/docs/guides/deploy-linodes-using-ansible/


# Usage
## Preparations
```shell
git clone https://github.com/kmpm/ansible-linode-nats
cd ansible-linode-nats

# get the submodules
git submodule init

# get/update some dependencies
## this is for a version of the linode inventory plugin that supports IPs
ansible-galaxy collection install community.general

# linode api
pip3 install linode_api4

# wireguard-tools, needed to generate keys
sudo apt install wireguard-tools

# set the token
export LINODE_ACCESS_TOKEN='<your token>'

# create a password for ansible vault
echo "Som3Sup3rImaginativ3Secr3tPassword" > vault-pass

#encrypt token and store in group_vars
ansible-vault encrypt_string $LINODE_ACCESS_TOKEN --name linode_token >> group_vars/demo.yml

#encrypt root password and store in group vars
ansible-vault encrypt_string 'Som3Sup3rImaginativ3Secr3tRootPassword' --name root_pass >> group_vars/demo.yml

./generate-host-keys.sh demo-linode-1
./generate-host-keys.sh demo-linode-2
./generate-host-keys.sh demo-linode-3

```

# This will probably cost you money on linode
__Warning!__ The following commands will possibly cost you money on linode and perhaps even
destroy any existing infrastructure you have there.
It works for me but you should read everything and understand what you are doing.
```shell
# create linodes
ansible-playbook linode_create.yml

# now wait some util they get up and running
# check inventory
ansible-inventory -i linode.yml --graph 

# you should get something like
> @all:
>  |--@group_demo:
>  |  |--demo-linode-1
>  |  |--demo-linode-2
>  |  |--demo-linode-3
>  |--@group_gateway_a:
>  |  |--demo-linode-1
>  |--@group_gateway_b:
>  |  |--demo-linode-2
>  |  |--demo-linode-3
>  |--@group_wireguard:
>  |  |--demo-linode-1
>  |  |--demo-linode-2
>  |  |--demo-linode-3
>  |--@ungrouped:


# ping the nodes just to check
ansible -m ping group_demo -i linode.yml -u root


# run the main playbook to set up wireguard + nats between the servers
ansible-playbook -i linode.yml -u root playbook.yml

``