#!/usr/bin/env bash

#进入docker-compose目录
cd ../docker-compose
echo '==================启动 mysql && redis && rabbitmq ========'
docker-compose -f docker-compose.yml up -d mysql
docker-compose -f docker-compose.yml up -d redis
docker-compose -f docker-compose.yml up -d rabbitmq

