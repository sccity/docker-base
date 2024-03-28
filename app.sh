#!/bin/bash

docker_compose="docker-compose -f docker-compose.yml"

if [[ $1 = "start" ]]; then
  echo "Starting Docker Base..."
	$docker_compose up -d
elif [[ $1 = "stop" ]]; then
	echo "Stopping Docker Base..."
	$docker_compose stop
elif [[ $1 = "restart" ]]; then
	echo "Restarting Docker Base..."
  $docker_compose down
  $docker_compose start
elif [[ $1 = "down" ]]; then
	echo "Tearing Down Docker Base..."
	$docker_compose down
elif [[ $1 = "rebuild" ]]; then
	echo "Rebuilding Docker Base..."
	$docker_compose down --remove-orphans
	$docker_compose build --no-cache
else
	echo "Unkown or missing command..."
fi