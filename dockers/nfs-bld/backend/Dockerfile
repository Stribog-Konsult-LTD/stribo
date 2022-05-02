FROM debian:latest

RUN   apt-get update \
	  && apt-get install -y --no-install-recommends -o APT::Immediate-Configure=0 \
		openjdk-11-jdk  \
		maven \
		net-tools iputils-ping \
		procps 

RUN echo "alias l='ls -plah --color=auto' " >> /root/.bashrc
