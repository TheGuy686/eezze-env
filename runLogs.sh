#!/bin/bash

docker logs --tail 1000 -f eezze_ws-stats_1 > ~/docker/logs/ws-stats.log&
docker logs --tail 1000 -f eezze_ws_1 > ~/docker/logs/ws-gen.log&
docker logs --tail 1000 -f eezze_rest_1 > ~/docker/logs/api.log&
docker logs --tail 1000 -f eezze_web_1 > ~/docker/logs/fe.log&
docker logs --tail 1000 -f eezze_web_jesper_1 > ~/docker/logs/fe-jesper.log&