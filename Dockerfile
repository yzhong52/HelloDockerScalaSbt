FROM openjdk:8

ENV SBT_VERSION 0.13.15

RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apr-get install openjdk-8-jdk && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

WORKDIR /HelloWorld

COPY . /HelloWorld

CMD sbt run
