#!/bin/bash
JENKINS_OS_USER="jenkins"
WDIR="/var/jenkins_home"

# If the source directory exists create it else exit
if [ ! -d "$WDIR/source" ]; then
    mkdir -p $WDIR/source/idempiere_source
    cd $WDIR/source/idempiere_source
    hg clone https://bitbucket.org/idempiere/idempiere
    chown -R $JENKINS_OS_USER:$JENKINS_OS_USER $WDIR/source
    mkdir $WDIR/buckminster-headless-4.5
    cd $WDIR/buckminster-headless-4.5
    wget https://github.com/hengsin/headless/raw/master/director_latest.zip
    unzip $WDIR/buckminster-headless-4.5/director_latest.zip -d $WDIR/buckminster-headless-4.5/
    cd $WDIR/buckminster-headless-4.5/director
    ./director -r https://github.com/hengsin/headless/raw/master/4.5/ -d $WDIR/buckminster-headless-4.5/ -p Buckminster -i org.eclipse.buckminster.cmdline.product
    cd $WDIR/buckminster-headless-4.5
    ./buckminster install https://github.com/hengsin/headless/raw/master/4.5/ org.eclipse.buckminster.core.headless.feature
    ./buckminster install https://github.com/hengsin/headless/raw/master/4.5/ org.eclipse.buckminster.pde.headless.feature
    ./buckminster install https://github.com/hengsin/headless/raw/master/4.5/ org.eclipse.buckminster.maven.headless.feature
    chown -R $JENKINS_OS_USER:$JENKINS_OS_USER $WDIR/buckminster-headless-4.5
    exit 0
fi
