FROM debian:jessie


RUN apt-get update && apt-get -y dist-upgrade && apt-get -y --no-install-recommends install wget gnupg
RUN wget http://pkg.yeti-switch.org/key.gpg -O - | apt-key add -
RUN echo "deb http://pkg.yeti-switch.org/debian/jessie unstable main ext" >> /etc/apt/sources.list
RUN echo "deb http://deb.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list
RUN echo "Package: *\nPin: release n=buster\nPin-Priority: 50\n\nPackage: python-git python-gitdb python-smmap python-tzlocal\nPin: release n=buster\nPin-Priority: 500\n\n" | tee /etc/apt/preferences
RUN wget --no-check-certificate https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add - && echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list

RUN apt-get update && apt-get -y --no-install-recommends install build-essential devscripts \
    ca-certificates apt-transport-https debhelper fakeroot lintian python-jinja2 \
    ruby2.6 ruby2.6-dev zlib1g-dev libpq-dev python-yaml postgresql-client-11 \
    git-changelog python-setuptools lsb-release curl

ADD . /build/yeti-web/
RUN sed -i '/host/s/127\.0\.0\.1/db/' /build/yeti-web/config/database.build.yml

WORKDIR /build/yeti-web/
CMD make package

