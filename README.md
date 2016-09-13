# Docker-Apache-php7-phalcon
A Dockerfile for developers to run a Phalcon 3 projet under php 7.0 and apache 2.4

## Before starting

This configuration was made to run a Phalcon project with a PostgreSQL database, but as you can see in the Dockerfile the extensions for MySql and other databases are available.
This should also work with Laravel or others frameworks, you just have the C Phalcon extension installed.
If you need i also made a proxy apache image : [Docker-Apache-2.4-Proxy](https://github.com/ZHAJOR/Docker-Apache-2.4-Proxy)

## Usage
First you have to make an image :
` docker build -t phalcon .`
Then a container :
`docker run -d -v /Path/To/api/:/var/www/html -p 12345:80 --name=contrainer-phalcobn phalcon`
The goal here is just to share the project directory with the container, so we can keep working on it.

## Logs
As you can see in the Dockerfile the apache logs are linked to **stderr** and **stdout**, so you can access them just by doing `docker logs container-phalcon`.

# Kitematic
The project is on the docker hub : [link](https://hub.docker.com/u/zhajor/)
Don't forget to change the VOLUMES (settings) with your local Phalcon project path.
Set a port as well so you will not have a random one each time you restart the container.

# Blog Article
I wrote about this, check [here](https://blog.zhajor.com/2016/09/a-docker-image-for-phalcon-and-tutorial/)
You can get some explanations from building the image to exploring the tutorial.

## Conclusion
Have fun !
