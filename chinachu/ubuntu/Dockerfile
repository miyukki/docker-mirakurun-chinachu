FROM ubuntu
LABEL maintainer "Yusei Yamanaka <yusei1128@gmail.com>"

ARG REPOSITORY="git://github.com/Chinachu/Chinachu.git"
ARG BRANCH="gamma"

ARG WORK_DIR="/usr/local/chinachu"

ARG USER_NAME="chinachu"
ARG USER_ID="1000"

RUN set -x \
	&& apt update \
	&& apt install -y \
		sudo \
		build-essential \
		curl \
		wget \
		git-core \
		python \
		# vainfo \
	&& useradd -m -u ${USER_ID} -U -s /bin/bash ${USER_NAME} \
	&& mkdir -p ${WORK_DIR} \
	&& git clone -b ${BRANCH} ${REPOSITORY} ${WORK_DIR} \
	&& chown -R ${USER_NAME}: ${WORK_DIR} \

# RUN set -x \
	# && git checkout ${BRANCH} \
	&& cd ${WORK_DIR} \
	&& echo 1 | sudo -H -u ${USER_NAME} ./chinachu installer \

# RUN set -x \
	# && cd ${WORK_DIR} \
	&& ./chinachu service operator  initscript | sudo -u ${USER_NAME} tee /tmp/chinachu-operator \
	&& ./chinachu service wui initscript | sudo -u ${USER_NAME} tee /tmp/chinachu-wui \
	&& sudo -u ${USER_NAME} mkdir log \
	\
	#&& chown root. /tmp/chinachu-operator /tmp/chinachu-wui \
	&& chmod u+x /tmp/chinachu-operator /tmp/chinachu-wui \
	&& mv /tmp/chinachu-operator /etc/init.d/ \
	&& mv /tmp/chinachu-wui /etc/init.d/ \
	\
	# cleaning
	&& cd / \
	# && npm cache clean \
	# && apk del --purge .build-deps \
	&& rm -rf /tmp/* \
	# && rm -rf /var/cache/apk/*

	# forward request and error logs to docker log collector
	#&& ln -sf /dev/stdout ${WORK_DIR}/log/operator \
	#&& ln -sf /dev/stdout ${WORK_DIR}/log/scheduler \
	#&& ln -sf /dev/stdout ${WORK_DIR}/log/wui

	# && apt remove -y \
	# 	build-essential \
	# 	curl \
	# 	wget \
	# 	git-core \
	# 	python \
	# 	vainfo \
	&& apt clean

COPY services.sh /usr/local/bin
# COPY config.sample.json ${WORK_DIR}

WORKDIR ${WORK_DIR}
CMD ["/usr/local/bin/services.sh"]
EXPOSE 10772 20772 5353
