FROM jenkins/jenkins:lts

EXPOSE 8080

USER root

# Install needed tools
RUN apt-get update && apt-get -y install zip mercurial htop rpl ant

# Copy buckminster and director for running using exec if they done exist
COPY run.sh /var/jenkins_home/run.sh

RUN chmod +x /var/jenkins_home/run.sh

USER jenkins
