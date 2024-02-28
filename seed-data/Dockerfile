FROM python:3.13-rc-slim

COPY . .

RUN python make-data.py

RUN apt update &&\
    apt install -y apache2 &&\
    apt install -y apache2-utils

CMD ["sh", "./generate-votes.sh"]
