FROM python:3.13-rc-slim

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "./app.py"]