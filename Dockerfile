FROM tmaczukin/debian
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

# Install OpenLDAP
RUN apt-get install -y slapd ldap-utils supervisor && apt-get clean

COPY assets/init /usr/local/sbin/init
RUN chmod 700 /usr/local/sbin/init && chown root:root /usr/local/sbin/init

COPY assets/slapd.conf /etc/supervisor/conf.d/slapd.conf

ENV LDAP_ROOTPASS root
ENV LDAP_DOMAIN maczukin.pl
ENV LDAP_ORGANISATION maczukin.pl

VOLUME ["/var/lib/ldap"]
VOLUME ["/etc/ldap/slapd.d"]

EXPOSE 389

ENTRYPOINT ["/usr/local/sbin/init"]
CMD ["start"]

