# Ansible Linode NATS

- https://www.linode.com/docs/guides/deploy-linodes-using-ansible/


# Usage
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

# set the token
export LINODE_ACCESS_TOKEN='<your token>'

# create a password for ansible vault
echo "Som3Sup3rImaginativ3Secr3tPassword" > vault-pass

#encrypt token and store in group_vars
ansible-vault encrypt_string $LINODE_ACCESS_TOKEN --name linode_token >> group_vars/demo.yml

#encrypt root password and store in group vars
ansible-vault encrypt_string 'Som3Sup3rImaginativ3Secr3tRootPassword' --name root_pass >> group_vars/demo.yml

make create

```