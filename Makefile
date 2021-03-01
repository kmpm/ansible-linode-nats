
.PHONY: usage
usage:
	@echo "make inventory                  - shows output from linode dynamic inventory"
	@echo "make create                     - creates a instance"

.PHONY: inventory
inventory:
	ansible-inventory -i linode.yml --graph 

.PHONY: create
create:
	ansible-playbook linode_create.yml

.PHONY: ping
ping: 
	ansible -m ping nats_group -i linode.yml -u root

.PHONY: requirements
requirements:
	ansible-galaxy collection install -r requirements.yml


playbook:
	ansible-playbook -i linode.yml -u root playbook.yml