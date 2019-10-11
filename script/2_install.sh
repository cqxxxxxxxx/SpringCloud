#!/usr/bin/env bash

#进入主目录
cd ..
echo '==================1.安装认证公共包到本地maven仓库=================='
#安装认证公共包到本地maven仓库
cd common && mvn install
echo '当前目录:' && pwd

#回到根目录
cd -

echo '==================2.安装认证客户端到本地maven仓库=================='
#安装认证客户端到本地maven仓库
cd auth/authentication-client && mvn install
echo '当前目录:' && pwd

#回到根目录
cd -

echo '==================4.3.构建镜像:注册中心, 配置中心, 消息中心========'
#构建镜像:注册中心
cd ./center/eureka
mvn package && mvn docker:build

#回到根目录
cd -

#构建镜像:消息中心
cd ./center/bus
mvn package && mvn docker:build

#回到根目录
cd -

echo '==================4.4.启动注册中心, 配置中心, 消息中心============'
#去docker-compose目录
cd docker-compose

#启动注册中心
docker-compose -f docker-compose.yml -f docker-compose.center.yml up -d eureka-server

#启动配置中心, 消息中心
#apollo
docker-compose -f docker-compose.yml -f docker-compose.config.yml up -d

#启动消息中心
docker-compose -f docker-compose.yml -f docker-compose.center.yml up -d bus-server

#回到根目录
cd -

echo '==================5.构建镜像并启动网关(gateway)相关服务==============='
#构建镜像:网关服务
cd ./gateway/gateway-web
mvn package && mvn docker:build

#回到根目录
cd -

#构建镜像:网关管理服务
cd ./gateway/gateway-admin
mvn package && mvn docker:build

#回到根目录
cd -

#去docker-compose目录
cd docker-compose

#启动网关服务
docker-compose -f docker-compose.yml -f docker-compose.spring-gateway.yml up -d gateway-web

#启动网关管理服务
docker-compose -f docker-compose.yml -f docker-compose.spring-gateway.yml up -d gateway-admin

#回到根目录
cd -

echo '==================6.构建镜像并启动组织(organization)相关服务=================='
#构建镜像:组织服务
cd ./sysadmin/organization
mvn package && mvn docker:build

#回到根目录
cd -

#去docker-compose目录
cd docker-compose

#启动组织服务
docker-compose -f docker-compose.yml -f docker-compose.auth.yml up -d organization

#回到根目录
cd -

echo '==================7.构建镜像并启动认证(auth)相关服务=================='
#构建镜像:认证服务
cd ./auth/authentication-server
mvn package && mvn docker:build

#回到根目录
cd -

#构建镜像:授权服务
cd ./auth/authorization-server
mvn package && mvn docker:build

#回到根目录
cd -

#去docker-compose目录
cd docker-compose

#启动网关服务
docker-compose -f docker-compose.yml -f docker-compose.auth.yml up -d authorization-server

#启动网关管理服务
docker-compose -f docker-compose.yml -f docker-compose.auth.yml up -d authentication-server

#回到根目录
cd -

echo '==================8.构建镜像并启动监控(monitor)相关服务==============='
#构建镜像:管理台服务
cd ./monitor/admin
mvn package && mvn docker:build

#回到根目录
cd -

#去docker-compose目录
cd docker-compose

#启动网关服务
docker-compose -f docker-compose.yml -f docker-compose.monitor.yml up -d monitor-admin

#回到根目录
cd -
