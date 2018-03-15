# Banda Health Jenkins Image

This image will install the Jenkins Build Server using docker-compose although one can still build an image and then use docker run.

We use the [jenkins/jenkins image](https://github.com/jenkinsci/docker/) and install other packages such mercurial.

# How to Use the Banda Health Jenkins Image

## Setting up Jenkins

1. Clone the jenkins repo from github

2. cd to the location of the repo

3. run the command docker-compose up -d

The jenkins portal will be available on port 9003 on the host machine for install http://localhost:9003

You can change this port in the docker-compose.yml file.

## Setting up Buckminster 4.5 and Director

1. Once you've started your image, then connect into the container using docker exec and then execute the script run.sh that was copied into the jenkins home directory:

docker exec -it name_of_jenkin_ container bash

bash /var/jenkins_home/run.sh

