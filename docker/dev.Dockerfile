FROM slack/anchor:latest

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
# ENV LC_ALL=en_US.UTF-8

RUN apt-get update \
  && apt-get install -y \
  git

# RUN useradd -m dev \
#   && echo "dev:dev" | chpasswd \
#   && adduser dev sudo

ENV NVM_DIR ~/.nvm
ENV NODE_VERSION v14.18.1
ENV NPM_VERSION 8.1.0

# USER dev
# WORKDIR /home/dev

# Installing Node
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
RUN source /root/.bashrc \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install --global npm@$NPM_VERSION

# Install Pure Prompt (https://github.com/sindresorhus/pure)
# RUN npm install --global pure-prompt


# Bash-it (https://github.com/Bash-it/bash-it)
ENV BASH_IT_THEME Metal
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
RUN . ~/.bash_it/install.sh

SHELL ["/bin/bash", "--login", "-c"]

CMD /bin/bash