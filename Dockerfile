FROM jenkins/jenkins:lts

EXPOSE 8080

ENV TZ Africa/Nairobi

USER root

# Install needed tools
RUN apt-get update && apt-get -y install zip \
    mercurial htop rpl ant tzdata vim

RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# Copy buckminster and director for running using exec if they done exist
COPY run.sh /var/jenkins_home/run.sh

RUN chmod +x /var/jenkins_home/run.sh

USER jenkins

HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1
