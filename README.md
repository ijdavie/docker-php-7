# Dockerfile and relevant configuration to host a LAMP stack using supervisor

## Install

    docker pull danielsamson/docker-php-7

## First run
    docker run -d -P --name php-7 -v /var/www/html/:/var/www/html/ danielsamson/docker-php-7

## Start the container

    docker start php-7

## Open a bash shell

    docker exec -it php-7 bash
   
