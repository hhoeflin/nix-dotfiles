# Introduction

We want to write an nginx configuration that can be run in user mode
and where a single port maps onto all ports on the system
via specifying the port as a directory.

## Running nginx in user mode

A basic configuration that can be run in non-root user mode can be found
on stackoverflow.

[Stackoverflow](https://stackoverflow.com/questions/42329261/running-nginx-as-non-root-user/62712043#62712043)

## Mapping all ports from localhost to an external one

The idea of mapping all ports of localhost onto an external port is taken from the
docker container in ml-tooling.

[ml-tooling-container](https://github.com/ml-tooling/ml-workspace)

In this docker container, an nginx configuration is running that makes
all ports inside the container available through a single external
port by specifying the port inside the container as a directory.

The configuration inside the container is at
[this line](https://github.com/ml-tooling/ml-workspace/blob/0d6c3730a2b29aedf6c5677a3f7d6d4d7b93e6b1/resources/nginx/nginx.conf#L232).

## Putting it together

We use the location settings of the mltooling together with the non-root user
settings to creat a new configurations file. The authentication part of the
ml-tooling settings are removed as they are not needed here.
