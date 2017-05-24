# Docker basic authorization proxy

This dockerfile build basic authorization proxy used nginx.

## Build

1. Run the following command.
```bash
$ docker build -t nginx-auth-proxy .
```

## Run

**Assumption**  
kibana running on host: kibana and listen port is 5601.
elasticsearch running on host: elasticsearch and listen port is 9200.
If you want to proxy from nginx to kibana, you run the following command.

```bash
$ docker run -dp 80:80 \
             -e USERNAME=admin \
             -e PASSWORD=admin \
             -e PROXY=kibana:5601,5602;elasticsearch:9200,9201 \
             nginx-auth-proxy
```

and then, you can access to `localhost:5602` or `localhost:9201` on browser.
