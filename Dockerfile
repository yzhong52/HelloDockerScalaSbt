FROM openjdk:8

ENV SBT_VERSION 1.5.5

RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://scala.jfrog.io/ui/native/debian-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

WORKDIR /HelloWorld

COPY . /HelloWorld

CMD sbt run
