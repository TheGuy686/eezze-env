#!/bin/bash

# Kill any previously started sessions with the name "eezze"
if screen -ls | grep -q "eezze"; then
    screen -ls | grep eezze | cut -d. -f1 | awk '{print $1}' | xargs -I {} screen -X -S {} quit
fi

screen -dmS eezze

screen -S eezze -X screen bash -c "cd /user_data/projects/eezze-docker-env && exec bash"
screen -S eezze -p 0 -X title "Docker Run"

screen -S eezze -X screen bash -c "cd ~/docker/api && exec bash"
screen -S eezze -p 1 -X title "BE Code"

screen -S eezze -X screen bash -c "cd ~/docker/api && exec bash"
screen -S eezze -p 2 -X title "BE Logs"

screen -S eezze -X screen bash -c "cd ~/docker/api && exec bash"
screen -S eezze -p 3 -X title "BE WS Logs"

screen -S eezze -X screen bash -c "cd ~/docker/api && exec bash"
screen -S eezze -p 4 -X title "BE WS Gen Logs"

screen -S eezze -X screen bash -c "cd ~/docker/api && exec bash"
screen -S eezze -p 5 -X title "BE Logger Logs"

screen -S eezze -X screen bash -c "cd ~/docker/web && exec bash"
screen -S eezze -p 6 -X title "FE Code"

screen -S eezze -X screen bash -c "cd ~/docker/web && exec bash"
screen -S eezze -p 7 -X title "FE Logs"

# screen -S eezze -X screen bash -c "cd ~/docker/web/plugins/visual-entity-editor && exec bash"
# screen -S eezze -p 7 -X title "FE EVEE"

./run-scri.sh &

screen -r eezze

# sleep 1

# screen -S eezze -d -p 0 -X stuff "npm run dev-local^M"

# sleep 3

# screen -S eezze -d -p 1 -X stuff "npm run api-logs^M"
# screen -S eezze -d -p 3 -X stuff "npm run ws-stats-logs^M"
# screen -S eezze -d -p 4 -X stuff "npm run ws-logger-logs^M"
# screen -S eezze -d -p 6 -X stuff "npm run logs^M"

# echo "Should be running successfully"
