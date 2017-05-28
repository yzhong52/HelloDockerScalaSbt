# A brief explanation of images and containers

An **image** is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

A **container** is a runtime instance of an image – what the image becomes in memory when actually executed. It runs completely isolated from the host environment by default, only accessing host files and ports if configured to do so.

# Scala Application

There are three files in this example application

* **build.sbt** defines the build related information, such as scala version
* **project/build.properties** defines the sbt version
* **src/main/scala/HelloWorld.scala** contain the "Hello Word" Scala application

To run this application, make sure you have `sbt` install on your machine. To begin with, let's check the `sbt` version: 

    ✗ sbt sbtVersion    
    ...
    [info] 0.13.15
    
If you don't have `sbt` installed on your machine, download it from http://www.scala-sbt.org/. 

After installing `sbt`, we can run the application simply by `sbt run`.  

    ✗ sbt run
    ...
    [info] Running HelloWorld 
    Hello, world!
    [success] Total time: 0 s, completed 01-Jun-2017 01:02:03 AM
    
# Dockerfile

To run the application, we require the computer to have installed Java and sbt. 

We choose the base image from `openjdk:8`:

    FROM openjdk:8
    
And we install `sbt` on top of that: 

    RUN \
      curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
      dpkg -i sbt-$SBT_VERSION.deb && \
      rm sbt-$SBT_VERSION.deb && \
      apt-get update && \
      apt-get install sbt && \
      sbt sbtVersion

Now run the build command. This creates a Docker image, which we’re going to tag using `-t` or `--tag` so it has a friendly name and version.

    docker build -t hello_world:v1 . 

The built image is in the machine’s local Docker image registry. We can list them via the docker images commend:

    docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    hello_world         v1                  2c43052fd1c5        8 minutes ago       774 MB
    openjdk             8                   ab0ecda9094c        11 days ago         610 MB
    ➜  ~ 

Finally, run the app with:

    docker run hello_world:v1
    [info] Loading project definition from /HelloWorld/project
    ...
    [info]   Compilation completed in 9.433 s
    [info] Running HelloWorld 
    Hello, world!

Reference: https://docs.docker.com/get-started
