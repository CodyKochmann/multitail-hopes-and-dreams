FROM debian

RUN apt update && apt install -y multitail

COPY ./entrypoint.sh /entrypoint.sh
COPY ./run.sh /run.sh
RUN chmod -v 700 /entrypoint.sh /run.sh

WORKDIR /

ENTRYPOINT ["/entrypoint.sh"]
