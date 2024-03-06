FROM python:latest

COPY . .

RUN apt update && apt install -y apache2 && apt install -y apache2-utils

RUN python make-data.py

CMD ["sh", "./generate-votes.sh"]
