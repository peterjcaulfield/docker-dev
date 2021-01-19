FROM node:15-alpine
RUN apk --update add bash git less openssh curl neovim && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
WORKDIR /root
COPY ./install.sh .
RUN ["chmod", "+x", "./install.sh"]
RUN ./install.sh
RUN rm ./install.sh
CMD ["/bin/bash"]
