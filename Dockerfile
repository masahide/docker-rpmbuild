FROM amazonlinux:2.0.20221210.0

LABEL maintainer="YAMASAKI Masahide <masahide.y@gmail.com>"
LABEL build_date="2023-01-02"

RUN yum groupinstall -y "Development Tools" \
 && yum install -y \
        rpmdevtools \
 && yum clean all \
 && rm -r -f /var/cache/* \
 && rpmdev-setuptree


COPY entrypoint.sh .
ENTRYPOINT ["/entrypoint.sh"]
