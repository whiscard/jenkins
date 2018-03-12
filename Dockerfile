FROM jenkins/jenkins:lts

#ENV JENKINS_SLAVE_AGENT_PORT 50001

# Expose the openmrs directory as a volume
#VOLUME /var/jenkins_home/                    

EXPOSE 8080

USER root

# Install needed tools
RUN apt-get update && apt-get -y install zip mercurial htop rpl ant

USER jenkins

# Copy and Install jenkins and buckminster and director
#COPY run.sh /var/jenkins/run.sh

#RUN chmod +x /var/jenkins/run.sh

#CMD /var/jenkins/run.sh
