FROM python:3.10
WORKDIR /code

COPY ./app/requirements.txt /code/requirements.txt

RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

CMD ["python", ""]