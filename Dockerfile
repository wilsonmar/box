FROM node:0.10.44-slim

ADD . /home/harry/box/

RUN cd /home/harry/box && npm install

ENTRYPOINT ["/home/harry/box/boot.sh"]
