FROM jenkins/jenkins:lts

ENV JENKINS_SLAVE_AGENT_PORT 50001

EXPOSE 8080

# Install jenkins and buckminster and director
COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
