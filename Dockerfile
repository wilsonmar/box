FROM shipimg/appbase:latest

ADD . /home/harry/box/

RUN cd /home/harry/box && npm install

ENTRYPOINT ["/home/harry/box/boot.sh"]
