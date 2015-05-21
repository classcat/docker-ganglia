FROM classcat/ubuntu-supervisord3:vivid
MAINTAINER ClassCat Co.,Ltd. <support@classcat.com>

########################################################################
# ClassCat/Ganglia Dockerfile
#   Maintained by ClassCat Co.,Ltd ( http://www.classcat.com/ )
########################################################################

#--- HISTORY -----------------------------------------------------------
# 21-may-15 : created.
#-----------------------------------------------------------------------

WORKDIR /usr/local
RUN apt-get update \
  && apt-get install -y ganglia-monitor rrdtool gmetad ganglia-webfrontend \
  && cp -p /etc/ganglia-webfrontend/apache.conf /etc/apache2/sites-enabled/ganglia.conf

WORKDIR /opt
COPY assets/cc-init.sh /opt/cc-init.sh

EXPOSE 22 80 8649/tcp 8649/udp 8651 8652

CMD /opt/cc-init.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
