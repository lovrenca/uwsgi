################################################################################
#                                                                              #
#                                 {o,o}                                        #
#                                 |)__)                                        #
#                                 -"-"-                                        #
#                                                                              #
################################################################################
#
# UWSGI image dockerfile
#
##################################---BASE---####################################

FROM ubuntu

################################################################################

################################---MAINTAINER---################################

MAINTAINER Lovrenc Avsenek <a.lovrenc@gmail.com>

################################################################################

###################################---BUILD---##################################

# Make enviorment noninteractive
ENV DEBIAN_FRONTEND noninteractive

#Add and lunch the install script
ADD install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh && sleep 5 && /tmp/install.sh
ADD default.yml /opt/uwsgi/default.yml

# Set the working conditions
WORKDIR /opt/web
EXPOSE 9000
CMD  uwsgi --yaml /opt/uwsgi/default.yml

################################################################################
