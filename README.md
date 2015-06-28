# uWSGI

This docker image runs uwsgi on port 9000.
Django is included.
The default config file used is located in /opt/uwsgi/default.yml
It includes any .yml config files located in to /opt/uwsgi/conf.d directory.
While the config file does include the vbasic configuration, it is unaware of your application.
You should give it the filloing two enviormental variables:

* UWSGI_CHDIR - your project root
* UWSGI_WSGI_FILE - location of the wsgi.py
>You can do extra configuration via enviormental variables, refer to uwsgi documentaion for that : uwsgi-docs.readthedocs.org/en/latest/
## Usage

You can then run this container like this:
```
docker run -d \
	-v <path to your app>:/opt/web \
	-e UWSGI_CHDIR=<path to your project> \
	-e UWSGI_WSGI_FILE=<path to wsgi.py> \
	--name uwsgi-container \
	lovrenca/uwsgi
```
You can then link a front web server to it, using it's exposed port 9000 as an upstream.

## docker-compose

But running an uwsgi container by itself doesn't really do much, it's real use is together with other containers needed to deploy an app.
This is an example configraion I used for running a django app.

```
nginx:
  image: nginx
  ports:
    - 127.0.0.1:80:80
  links:
    - uwsgi:uwsgi
uwsgi:
  image: lovrenca/uwsgi
  volumes:
    - ./:/opt/web
  links:
    - db:db
  environment:
    - UWSGI_CHDIR=/opt/web
    - UWSGI_WSGI_FILE=<path to wsgi.py file>

db:
  image: postgres

```
This should server as a good enough ilustration of a basic setup, of course aditional configuration of nginx and postgres are required. I will post a working enviorment in a github repo at a later date.
Specifics such as paths, custom volumes and enviormentas were of course stripped out.

## Tips and tricks

As this image includes django, it is possible to attach to the container and issue commands in it's bash shell. 

```
docker exec -ti <container-name> bash
```