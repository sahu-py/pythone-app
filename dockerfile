FROM python:2.7
RUN mkdir /usr/src/app
WORKDIR /usr/src/app/
COPY requirement.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirement.txt
COPY . .
VOLUME ["app-data"]
CMD ["gunicorn", "-b", "0.0.0.0:8080", "-c", "gunicorn.conf.py", "main:app"]
