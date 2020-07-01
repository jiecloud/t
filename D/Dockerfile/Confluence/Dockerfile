FROM atlassian/confluence-server:7.5.2
ENV  JAVA_OPTS='-Duser.timezone=GMT+08'
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y nano vim \
    && apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

COPY "mysql-connector-java-5.1.49.jar" "/opt/atlassian/confluence/lib"
