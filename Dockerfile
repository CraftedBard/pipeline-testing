# syntax = docker/dockerfile:experimental
# begin foundation
FROM python:3.8.4-alpine3.12 as foundation

RUN mkdir -p /usr/app

RUN apk add --no-cache curl jq g++ python3 python3-dev py-pip linux-headers libffi-dev openssl-dev  bash postgresql-libs postgresql-dev
RUN pip3 install poetry

WORKDIR /usr/app

ADD pyproject.toml .

RUN poetry install


# end foundation
# begin application addition
FROM foundation as application

COPY --from=foundation / /

ADD pipeline-testing/demo.py .
ADD entrypoint.sh .
RUN chmod +x entrypoint.sh

ENV FLASK_APP=demo

# end application
# begin production
FROM python:3.8.4-alpine3.12 as production

COPY --from=application / /

ENTRYPOINT ["./entrypoint.sh"]


# end production
