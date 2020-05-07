docker run -d --rm --name v2ray -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws:0.08 e1.nano1.xyz V2RAY_WS && sleep 3s && sudo docker logs v2ray
