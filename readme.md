# Getting Started With Docker, Scala & Sbt

## Scala Application

There are three files in this example application:

* **build.sbt** defines the build related information. We defined the name of the project, version number, and scala version here.

```
name := "HelloWorld"
version := "1.0"
scalaVersion := "2.12.2"
```

* **project/build.properties** defines the sbt version. 

> There are two sbt versions. One is for building the project itself, which is what is defined in the **build.properties** file here. There is a second sbt version that we'll cover later, which is the `sbt` installed on the machine. We sometimes refer that as `sbt-launcher` and it is used to  download and run a particular sbt version for building the project.

```
sbt.version = 0.13.15
```

* **src/main/scala/HelloWorld.scala** is our main application which simply print "Hello Word" on the console.

```
object HelloWorld {
  def main(args: Array[String]): Unit = {
    println("Hello, world!")
  }
}
```

## Sbt

To run this application, make sure you have `sbt` (a.k.a. `sbt-launcher`) install on your machine. To begin with, let's check the `sbt` version: 

    $ sbt sbtVersion    
    ...
    [info] 0.13.15

One launcher can launch many versions of sbt, and is generally backwards compatible. Therefore, this version number doesn't necessarily have to match the version number defined in **project/build.properties**. But, in general, we would like to keep this `sbt` up to date.  
    
If you don't have `sbt` installed on your machine, check the download page on [scala-sbt.org](http://www.scala-sbt.org/download.html). For example, on MacOS, you can install it via `brew install sbt`.

After installing `sbt`, we can run the application simply by `sbt run`. The command will take care of compiling the source code and launching the application. 

    $ sbt run
    ...
    [info] Running HelloWorld 
    Hello, world!
    [success] Total time: 0 s, completed 01-Jun-2017 01:02:03 AM
  
# Docker

## Dockerfile

To run the application, we require the computer to have installed both `Java` and `sbt`. And that's what we are going to specified in the Dockerfile.

We choose [`openjdk:8`](https://hub.docker.com/_/openjdk/) as our base image to start with.

    FROM openjdk:8
    
And we install `sbt` on top of that: 

    RUN \
      curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
      dpkg -i sbt-$SBT_VERSION.deb && \
      rm sbt-$SBT_VERSION.deb && \
      apt-get update && \
      apt-get install sbt && \
      sbt sbtVersion

Set the working directory to `HelloWorld`:

    WORKDIR /HelloWorld
    
Copy the current directory contents into the container at `HelloWorld`:

    ADD . /HelloWorld 

Run `stb run` when the container launches:

    CMD sbt run

## Docker image and container

An **image** is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

A **container** is a runtime instance of an image – what the image becomes in memory when actually executed. It runs completely isolated from the host environment by default, only accessing host files and ports if configured to do so.

Now run the build command to create a Docker image. We tag it using `-t` so it has a friendly name and version.

    $ docker build -t hello_world:v1 .
    ... 
    Successfully built 8508c6ecdf78
    Successfully tagged hello_world:v1

The built image is in the machine’s local Docker image registry. We can list them via the docker images commend:

    $ docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    hello_world         v1                  2c43052fd1c5        8 minutes ago       774 MB
    openjdk             8                   ab0ecda9094c        11 days ago         610 MB
    ➜  ~ 

Finally, run the app in the container:

    $ docker run hello_world:v1
    [info] Loading project definition from /HelloWorld/project
    ...
    [info]   Compilation completed in 9.433 s
    [info] Running HelloWorld 
    Hello, world!

Reference: https://docs.docker.com/get-started
