#!/bin/bash

sleep 2;

screen -S eezze -d -p 0 -X stuff "npm run dev-local^M"

screen -S eezze -p 0 -X title "Docker Run"

sleep 11;

screen -S eezze -d -p 1 -X stuff "cd ~/docker/api\n"
screen -S eezze -d -p 2 -X stuff "cd ~/docker/api && npm run api-logs\n"
screen -S eezze -d -p 3 -X stuff "npm run ws-stats-logs\n"
screen -S eezze -d -p 4 -X stuff "npm run ws-gen-logs\n"
screen -S eezze -d -p 5 -X stuff "npm run ws-logger-logs\n"
screen -S eezze -d -p 6 -X stuff "cd ~/docker/web && clear \n"
screen -S eezze -d -p 7 -X stuff "npm run logs\n"
# screen -S eezze -d -p 8 -X stuff "sleep 4 && cd ~/docker/web/plugins/visual-entity-editor && node content-server.js\n"

sleep 2;

screen -S eezze -d -p 8 -X stuff "exit\n"