FROM	ubuntu:16.04

RUN	apt-get update &&\
	apt-get install -y qemu-kvm bridge-utils iproute python

COPY	qemu-mac-hasher.py /usr/bin/qemu-mac-hasher.py
COPY	run_vm.sh /root/run_vm.sh

WORKDIR /virt_machines	

VOLUME	/virt_machines

CMD	[ "/root/run_vm.sh" ]
