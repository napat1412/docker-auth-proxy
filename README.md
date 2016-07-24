# Docker basic authorization proxy

This dockerfile build basic authorization proxy used nginx.

## Build

1. Run the following command.
```bash
$ docker build -t nginx-auth-proxy .
```

## Run

**Assumption**  
kibana running on docker and listen port is 5601.
If you want to proxy from nginx to kibana, you run the following command.

```bash
$ docker run -dp 80:80 \
             --link=kibana:kibanaalias
             -e USERNAME=hoge \
             -e PASSWORD=age \
             -e ADDRESS=kibana:5601 \
             nginx-auth-proxy
```

and then, you can access to `localhost` on browser.
