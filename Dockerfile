FROM ubuntu:latest as builder

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN mkdir -p /opt/cgit/

ADD scripts/build.sh /opt/cgit/
ADD scripts/setup_build.sh /opt/cgit/
WORKDIR /opt/cgit/

RUN chmod +x ./setup_build.sh && ./setup_build.sh

RUN chmod +x ./build.sh && ./build.sh

FROM ubuntu:latest

LABEL maintainer="alexis.lowe@protonmail.com"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="chimbosonic/dump1090"
LABEL org.label-schema.description="dump1090 container"
LABEL org.label-schema.vcs-url="https://gitlab.com/chimbosonic/dump1090-container"
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ADD scripts/install.sh ./
ADD config/cgit.conf /etc/apache2/sites-available/cgit.conf
ADD config/cgitrc /etc/cgitrc
ADD config/supervisord.conf /etc/supervisord.conf

COPY --from=builder /var/www/htdocs/cgit /var/www/htdocs/cgit

COPY --from=builder /usr/local/lib/cgit /usr/local/lib/cgit

RUN chmod +x ./install.sh && ./install.sh

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s CMD curl --fail -I -L 'http://127.0.0.1/cgit' || exit 1

ENTRYPOINT ["/usr/bin/supervisord"]

CMD ["-c", "/etc/supervisord.conf"]