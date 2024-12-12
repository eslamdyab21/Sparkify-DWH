FROM mysql:8.0-debian

RUN apt update
RUN apt install python3-pip -y
RUN apt install cron -y
RUN apt install nano -y

WORKDIR /dwh

COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt --break-system-packages

COPY . .

RUN service cron start