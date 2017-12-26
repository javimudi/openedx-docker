# Open edX quick install (in Docker containers)

This will allow you to quickly setup a working Open edX platform. It was designed to be a **one-click production install of Open edX**.

This was designed for non-technical people: knowing how to launch and ssh into a server should be enough. But if you are technically savvy, you should be able to modify each and every step of the deployment process, without too much effort.

## Quickstart

All you have to do is run:

    make all

There is no step #2. You will be asked some questions about the configuration of your Open edX platform. The build step will take some time, but then you will have both an LMS and a CMS running behind a web server on port 80. You should be able to access your platform at the address you gave during the configuration phase.

We strongly recommend reading the more detailed instructions below to understand what is going on exactly.

## Setup

The only prerequisite for running this is a working docker install. You will need both docker and docker-compose. Follow the instructions from the official documentation:

- [Docker install](https://docs.docker.com/engine/installation/)
- [Docker compose install](https://docs.docker.com/compose/install/)

Note that the web server container will bind to port 80, so if you already have a web server running (Apache or Nginx, for instance), you should stop it.

## Step-by-step install

Prepare build:

    make configure

Build docker images:

    make build # go get a coffee

Building the images may require a long time, depending on your bandwidth, as you will have to checkout the `edx-platform` repository (> 1 Gb) as well as the python dependencies.

Then, before the first run you will need to migrate the database and collect static assets. These two steps should only be run once:

    make migrate
    make assets

You are ready to go. You can now launch the various services:

    make up

The LMS and the CMS should then be reachable at the address you specified.

Note that in production, you will probably want to daemonize, so you should run `make daemon` instead of `make up`.

## Additional commands

To import the Open edX demo course, run:

    make import-demo-course

## Development

Open a bash in the lms:

    docker-compose run lms bash

Open a python shell in the lms or the cms:

    make lms-shell
    make cms-shell

## Disclaimers & Warnings

This project is the follow-up of my work on an [install from scratch of Open edX](https://github.com/regisb/openedx-install). It does not rely on any hack or complex deployment script. In particular, we do not use the Open edX [Ansible deployment playbooks](https://github.com/edx/configuration/). That means that the folks at edX.org are *not* responsible for troubleshooting issues of this project. Please don't bother Ned :)

If you have a problem, feel free to open a [Github issue](https://github.com/regisb/openedx-docker/issues) that describes:
- the problem you are facing: this includes the exact error message, or a screenshot of the error.
- what action triggered the error: which command line instruction, which url you tried to access, etc.
- any error logs that you may find: you may want to take a look at the files in `data/lms/logs`, for instance.

In creating this, I focused on a lean, simple production install with few features because I feel that production deployment of Open edX is too difficult and not transparent enough. I wrote this for a non-developers, non-sysadmins audience. But if you want to to tweak the inside of Open edX *and* you are technically savvy, feel free to hack the docker configuration files and checkout edx-platform from a forked repo.
