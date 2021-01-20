FROM node:15-alpine

RUN apk upgrade &&\
    apk --update add util-linux bash git less openssh curl build-base python3-dev py3-pip neovim the_silver_searcher tmux && \
    pip3 install neovim && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

WORKDIR /root

COPY ./install.sh .
RUN ["chmod", "+x", "./install.sh"]
RUN ./install.sh
RUN rm ./install.sh

ENV TERM xterm

CMD ["/bin/bash"]
