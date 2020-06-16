FROM alpine
MAINTAINER wanjie <webmaster@wanjie.info>
RUN apk --no-cache add curl openssh-client gcc util-linux linux-headers python3 py3-pip python3-dev libressl-dev musl-dev libffi-dev libxml2-dev libxml2 libxslt-dev && \
pip install --upgrade pip && \
pip install requests datetime cryptography apscheduler bandersnatch && \
pip  install --no-user jira jira && \
rm -rf /var/cache/apk/*
COPY jira_task_moni.py /workspace/jira_task_moni.py
