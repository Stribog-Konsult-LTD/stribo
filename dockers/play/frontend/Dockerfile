FROM nginx


RUN   apt-get update \
	  && apt-get install -y --no-install-recommends -o APT::Immediate-Configure=0 \
		net-tools \
		iputils-ping \
		procps \
		netcat \
		socat \
		nano

ADD cmd.sh /cmd.sh

CMD ["/cmd.sh"]
