FROM atlassian/confluence-server:7.5.2
MAINTAINER wanjie <jie.wan@daocloud.io>
ENV  JAVA_OPTS='-Duser.timezone=GMT+08 -Dconfluence.document.conversion.fontpath=/var/atlassian/application-data/confluence/fonts/ '
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y nano vim  fontconfig xfonts-utils fonts-arphic-ukai \
    && apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

COPY "mysql-connector-java-5.1.49.jar" "/opt/atlassian/confluence/lib"
