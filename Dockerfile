FROM node:15-alpine
RUN apk --update add bash git less openssh curl build-base python3-dev py3-pip neovim && \
    pip3 install neovim && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
WORKDIR /root
COPY ./install.sh .
RUN ["chmod", "+x", "./install.sh"]
RUN ./install.sh
RUN rm ./install.sh
CMD ["/bin/bash"]
