# https://github.com/ppodgorsek/docker-robot-framework
FROM ppodgorsek/robot-framework

USER root 

RUN pip3 install --upgrade pip \
    && python3 -m pip install --upgrade setuptools \
    && apk add \
    gcc \
    g++ \
    make \
    linux-headers \
    npm \
    && pip3 install --no-cache-dir  --force-reinstall -Iv grpcio==1.33.2

COPY requirements.txt ./

RUN pip3 install -r requirements.txt \
    && rfbrowser init

USER ${ROBOT_UID}:${ROBOT_GID}
