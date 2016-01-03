# istepanov/hackpad

[Hackpad](https://github.com/dropbox/hackpad) Docker image

Docker Hub [link](https://hub.docker.com/r/istepanov/hackpad/)

### Environment variables

* `ADMIN_EMAILS` - comma-separated superuser emails (default: `admin@example.com`)
* `DB_HOST` - mysql host (default: `mysql`)
* `DB_PORT` - mysql port (default: `3306`)
* `DB_NAME` - mysql database name (default: `hackpad`)
* `DB_USERNAME` - mysql user (default: `hackpad`)
* `DB_PASSWORD` - mysql user password (default: `password`)
* `TOP_DOMAINS` - comma-separated top level domains (default: `localhost,localbox.info`)
* `USE_HTTPS_URLS` - should hackpad emit the absolute urls using https as opposed to http (default: `false`)

### Advanced Example: Running the container behind a reverse proxy

```
docker run --name hackpad --link common-mysql:mysql -p 127.0.0.1:8002:9000 -e TOP_DOMAINS=localhost,localbox.info,www.yourdomain.com -e USE_HTTPS_URLS=true -d istepanov/hackpad
```

Assumptions:
* You what to run hackpad on www.yourdomain.com by using a reverse proxy on the host machine that sends requests to the container
* There already exists a running instance of the official mysql container. In this example I named it common-mysql, so change the name to the name you are using. The command above also assumes your mysql instance has a hackpad db and user as described above in the defaults.

Notes:
* The command below exposes the internal port 9000 of the container to the 8002 port on the localhost of the parent host. You then need to reverse proxy 127.0.0.1:8002 externally.
* Add your domain to the list of TOP_DOMAINS. If you do not do this and you set up a reverse proxy then the absolute URLs emitted by hackpad will be incorrect. Also don't forget to configure your reverse proxy to send the host header to the container.
* This example assumes your domain is using strictly https and not using http at all. In this case, we are setting the environment variable USE_HTTPS_URLS to true.
