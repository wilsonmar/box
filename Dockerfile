FROM shipimg/appbase:latest

ADD . /home/dv/

RUN mkdir -p /home/harry/my_projects/
RUN cd /home/dv && npm install

ENTRYPOINT ["/home/dv/boot.sh"]
