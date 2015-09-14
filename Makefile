t:
	vagrant ssh -c 'cd /vagrant && sudo sh -x test.sh'

setup:
	vagrant halt
	vagrant destry --force
	vagrant up
