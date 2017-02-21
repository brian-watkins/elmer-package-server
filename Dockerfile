## Dockerfile for a haskell environment
FROM ubuntu:trusty
# FROM       debian:jessie
# MAINTAINER Chris Biscardi <chris@christopherbiscardi.com>

## ensure locale is set during build
ENV LANG            C.UTF-8


RUN sudo apt-get update
RUN sudo apt-get install -y software-properties-common curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -; \
    sudo apt-get install -y nodejs
RUN npm install -g elm elm-test
RUN sudo add-apt-repository -y ppa:hvr/ghc
RUN sudo apt-get update
RUN sudo apt-get install -y zlib1g-dev cabal-install-1.22 ghc-7.10.3

ENV PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"

WORKDIR /opt/server

RUN cabal update
RUN cabal sandbox init

COPY ./elm-compiler/ /opt/server/elm-compiler

RUN cabal sandbox add-source ./elm-compiler

COPY ./elm-package/elmer-package.cabal /opt/server/elmer-package/elmer-package.cabal

RUN cabal install -j --only-dependencies --ghc-options="-w" ./elmer-package

COPY ./elm-package/ /opt/server/elmer-package

RUN cabal install -j --bindir=/usr/local/bin ./elmer-package

COPY ./sample/ /opt/server/sample

# ENTRYPOINT ["elm-package"]

# CMD [ "/bin/bash" ]

CMD [ "cp", "/usr/local/bin/elmer-package", "/opt/server/linux-bin" ]
