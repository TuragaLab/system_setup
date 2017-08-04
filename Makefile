# CURDIR is set to the directory this file lives when make is called
# the .PHONY: declarations tell make that rule is not a file, just the name of a rule


# Check for root
.PHONY: amroot
amroot:
ifneq ($(EUID),0)
	@echo "Please run as root user"
	@exit 1
endif


# tells curl where to look for certificates
.PHONY: curlrc
curlrc:
		cp ${CURDIR}/config_files/.curlrc ~/.curlrc


.PHONY: docker
docker: docker_install


.PHONY: docker_install
docker_install: curlrc amroot
		sudo apt-get update && \
		sudo apt-get install apt-transport-https ca-certificates curl software-properties-common && \
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
	 	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
		sudo apt-get update && \
		sudo apt-get install docker-ce
