FROM	jenkinsci/jenkins

# install ansible
USER	root
RUN	apt-get update -qq &&\
	apt-get install -qqy \
		python-pip \
		python-dev \
		libssl-dev \
		libffi-dev \
		python-yaml \
		python-crypto \
		python-httplib2 \
		python-jinja2 \
		python-paramiko \
		python-pkg-resources \ 
		python-selinux \
		sshpass \
		python-netaddr &&\
	pip install ansible

USER	jenkins
