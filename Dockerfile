FROM busybox
COPY . /context
WORKDIR /context
CMD find .
COPY . /content
