# uWSGI

This docker image runs uwsgi on port 9000.
Django is included.
The default config file used is located in /opt/uwsgi/default.yml
It includes any .yml config files located in to /opt/uwsgi/conf.d directory.
While the config file does include the vbasic configuration, itis unaware of your application and you should mount an appropriate config file into the 
conf.d directory.

your config file should look something like this:
```
	chdir: </opt/web>
	wsgi-file: <wsgi.py path>
```

## Usage

You can then run this container like this:
```
docker run -d \
	-v <path to your app>:/opt/web \
	-v <your config file>:/opt/uwsgi/conf.d/custom.yml \
	--name uwsgi-container \
	lovrenca/uwsgi
```
You can then link a front web server to it, using it's exposed port 9000 as an upstream.

## docker-compose

But running an uwsgi container by itself doesn't really do much, it's real use is together with other containers needed to deploy an app.
This is an example configraion I used for running a django app.

```
```

## Tips and tricks

As this image includes django, it is possible to attach to the container and issue commands in it's bash shell. 

```
docker exec -ti <container-name> bash
```