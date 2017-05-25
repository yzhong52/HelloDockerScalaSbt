# Dockerfile + sbt
    
    docker build -tag hello_world . 
    docker run hello_world
    
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



Reference: https://docs.docker.com/get-started
