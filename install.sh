#!/bin/bash

################################################################################
#                                                                              #
#                                 {o,o}                                        #
#                                 |)__)                                        #
#                                 -"-"-                                        #
#                                                                              #
################################################################################
#
# UWSGI install script
#
##############################---VARIABLES---###################################

BUILD_DIR="/tmp/uwsgi"

################################################################################

##################################---ENV---#####################################

set +e

################################################################################

###############################---EXECUTION---##################################


echo "> Go to build directory"
mkdir "${BUILD_DIR}"
cd "${BUILD_DIR}"

echo "> Update the system"
apt-get update -y 
apt-get upgrade -y

echo "> Install the build dependencies"
apt-get -y install \
	build-essential \
	python-dev \
	python-pip \
	curl
apt-get clean
apt-get install -U pip

echo " >Install uwsgi"
pip install -U uwsgi
mkdir -p /opt/uwsgi/conf.d

echo " > Install django"
pip install -U django

echo " > Cleanup"
rm -fr "${BUILD_DIR}"

################################################################################
