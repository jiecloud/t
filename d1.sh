#!/bin/bash
# Author: jie.wan@daocloud.io
# Created at 2020-02-14
# Usage: curl https:/cnrock.github.io/t/daomonit.sh | bash
# Usage: curl https:/cnrock.github.io/t/d1.sh | bash

# part1,解决面板找不到主机，提示“连接超时，请刷新重联” 问题
apt-get update --fix-missing
apt-get install ca-certificates -y
service daomonit restart

# part2,解决x509问题
echo -n | openssl s_client -showcerts -connect daocloud.io:443 2>/dev/null \
| sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > \
 /usr/local/share/ca-certificates/ca.crt
update-ca-certificates
service docker restart

#part3,下载dao-2048测试
docker pull daocloud.io/daocloud/dao-2048:latest

#part4,再次重启监控进程
service daomonit restart
