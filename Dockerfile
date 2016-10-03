FROM ubuntu

MAINTAINER ROSSINNO, LTD <saymon@saymon.info>

ENV SAYMON_AGENT_LOGBACK_CONFIGURATION_FILE="/opt/saymon-agent/conf/logback-upstart.xml"
ENV SAYMON_AGENT_UPDATE_DIRECTORY="/tmp"

ADD http://www.saymon.info/downloads/saymon-agent-rl-linux-x64-jre.tar.gz /opt

RUN tar xvf /opt/saymon-agent-rl-linux-x64-jre.tar.gz -C /opt/. \
&& rm /opt/saymon-agent-rl-linux-x64-jre.tar.gz
RUN adduser --system --no-create-home saymon \
&& mkdir /opt/saymon-agent/scripts \
&& chown -R saymon:nogroup /opt/saymon-agent

RUN mkdir /var/log/saymon \
&& chown -R saymon:nogroup /var/log/saymon

VOLUME /var/log/saymon
VOLUME /opt/saymon-agent/scripts

USER saymon

WORKDIR /opt/saymon-agent

ENTRYPOINT ["/bin/bash"]

CMD ["-c","/opt/saymon-agent/saymon-agent.sh > /var/log/saymon/saymon-agent.out 2>&1"]
