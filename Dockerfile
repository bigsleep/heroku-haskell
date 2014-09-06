FROM heroku/cedar:14

ENV PATH $PATH:/.cabal/bin

ENV LANG   C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install libgmp10-dev make gcc libc6-dev ca-certificates zlib1g-dev wget --no-install-recommends -y && apt-get clean

# install ghc-7.8.3
RUN cd /tmp \
  && wget -q http://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-x86_64-unknown-linux-deb7.tar.xz \
  && tar -xvf ghc-7.8.3-x86_64-unknown-linux-deb7.tar.xz \
  && cd ghc-7.8.3 \
  && ./configure \
  && make install \
  && cd /tmp \
  && rm -rf ./*

# install cabal
RUN cd /tmp \
  && wget -q https://www.haskell.org/cabal/release/cabal-install-1.20.0.3/cabal-install-1.20.0.3.tar.gz \
  && tar -xvf cabal-install-1.20.0.3.tar.gz \
  && cd ./cabal-install-1.20.0.3 \
  && ./bootstrap.sh --global \
  && cd /tmp \
  && rm -rf ./*

# install happy, alex
RUN cabal update && cabal install happy alex --global && rm -rf /.cabal
