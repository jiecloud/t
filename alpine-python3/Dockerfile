Dockerfile FROM alpine
MAINTAINER wanjie <webmaster@wanjie.info>
RUN apk --no-cache add curl openssh-client python3 py3-pip && \
pip3 install --upgrade pip3 && \
pip3 install time && \
pip3 install requests && \
pip3 install datetime && \
pip3 install json && \
rm -rf /var/cache/apk/*

COPY jira_task_moni.py /workspace/jira_task_moni.py

CMD ["python3","/workspace/jira_task_moni.py"]
