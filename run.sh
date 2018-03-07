## NOTE: this is not an automated isntall script (not yet)
## The below steps help you create an independent jenkins machine to build iDempiere and your plugins
## Because Jenkins runs on port 8080 by default, you will probably want to install the below on a dedicated machine
## This script was last successfully run on Ubuntu 14.04

## NOTE: if you are installing this in an AWS VPC and you are getting the following error:
##    sudo: unable to resolve host
## Execute this script: https://bitbucket.org/cboecking/idempiere-installation-script/src/default/utils/setHostName.sh

## ASSUMPTIONS
## Ubuntu 16.04
## local OS username = ubuntu
JENKINS_OS_USER="jenkins"

#####Install needed tools
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install jenkins zip mercurial htop s3cmd openjdk-8-jdk rpl ant

## NOTE: Jenkins will be launched as a daemon up on start. See the following for more detail:
##    /etc/init.d/jenkins
##    https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu (search google for "install jenkins")

#####clone a local repository of iDempiere
#  doing so insulates you (and jenkins) from the many changes that happen in the main bitbucket repository
#  FYI - jenkins will create yet another clone for its build purposes
cd /opt/
sudo mkdir source
sudo chown -R $JENKINS_OS_USER:$JENKINS_OS_USER source
cd source
sudo mkdir idempiere_source
cd idempiere_source
hg clone https://bitbucket.org/idempiere/idempiere

#Reference
#http://wiki.idempiere.org/en/Building_iDempiere_without_Eclipse

#####Install Director and Buckminster 4.5 - used for iDempiere release3.x and release4.x and release5.x
sudo mkdir /opt/buckminster-headless-4.5
cd /opt/buckminster-headless-4.5
sudo wget https://github.com/hengsin/headless/raw/master/director_latest.zip
sudo unzip /opt/buckminster-headless-4.5/director_latest.zip -d /opt/buckminster-headless-4.5/

cd /opt/buckminster-headless-4.5/director
sudo ./director -r https://github.com/hengsin/headless/raw/master/4.5/ -d /opt/buckminster-headless-4.5/ -p Buckminster -i org.eclipse.buckminster.cmdline.product

cd /opt/buckminster-headless-4.5
sudo ./buckminster install https://github.com/hengsin/headless/raw/master/4.5/ org.eclipse.buckminster.core.headless.feature
sudo ./buckminster install https://github.com/hengsin/headless/raw/master/4.5/ org.eclipse.buckminster.pde.headless.feature
sudo ./buckminster install https://github.com/hengsin/headless/raw/master/4.5/ org.eclipse.buckminster.maven.headless.feature
