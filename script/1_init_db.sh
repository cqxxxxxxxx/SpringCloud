#!/usr/bin/env bash

#进入docker-compose目录
cd ../docker-compose
read -r -p "确认数据库已经启动完毕 [Y/n] " envConfirm
case $envConfirm in
    [yY][eE][sS]|[yY])
		echo "Yes 继续执行"
		;;
    [nN][oO]|[nN])
		echo "No 终止执行"
		exit 1
       	;;
    *)
		echo "Invalid input... 终止执行"
		exit 1
		;;
esac

echo '================== 进行数据库初始化工作 (auth, gateway, sysadmin, apollo) ========'
docker-compose -f docker-compose.yml -f docker-compose.db-init.yml up mysql-init

