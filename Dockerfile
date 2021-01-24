FROM node:15-alpine

RUN apk upgrade && \
    apk --update add \
        zsh-vcs \
        util-linux \
        netcat-openbsd \
        tree \
        jq \
        zsh \
        bash \
        git \
        less \
        openssh \
        curl \
        build-base \
        python3-dev \
        py3-pip \
        neovim \
        the_silver_searcher \
        tmux && \
    pip3 install neovim && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

WORKDIR /root

COPY ./*.sh .
RUN chmod +x *.sh
RUN ./install.sh
RUN rm *.sh

ENV TERM xterm

CMD ["/bin/zsh"]
