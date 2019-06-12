## copy from builder only needed with multistage builds
FROM golang:1.12.5-stretch

LABEL author="Bernhard Fuchs"

WORKDIR $GOPATH/src/github.com/btcsuite/btcd

# Grab and install the latest version of of btcd and all related dependencies.
RUN git clone https://github.com/btcsuite/btcd.git . \
  &&  GO111MODULE=on go install -v . ./cmd/...

# Expose testnet ports (server, rpc)
EXPOSE 18333 18334

# Expose simnet ports (server, rpc)
EXPOSE 18555 18556

# Expose segnet ports (server, rpc)
EXPOSE 28901 28902

COPY "start-btcctl.sh" .
COPY "start-btcd.sh" .

RUN mkdir "/rpc" "/root/.btcd" "/root/.btcctl" \
  &&  touch "/root/.btcd/btcd.conf" \
  &&  chmod +x start-btcctl.sh \
  &&  chmod +x start-btcd.sh
## TODO: if necessary create certificates
# Manually generate certificate and add all domains, it is needed to connect
# "btcctl" and "lnd" to "btcd" over docker links.
# && "/bin/gencerts" --host="*" --directory="/rpc" --force

## BTC wallet
RUN git clone https://github.com/btcsuite/btcwallet $GOPATH/src/github.com/btcsuite/btcwallet \
  &&  cd $GOPATH/src/github.com/btcsuite/btcwallet \
  &&  GO111MODULE=on go install -v . ./cmd/...
## TODO: create BTC-Wallet config file https://github.com/btcsuite/btcwallet

## install locales, tmux, vi
RUN apt-get update \
  ## tmux needs locale en_US.UTF-8 installed
  ## https://serverfault.com/questions/54591/how-to-install-change-locale-on-debian
  &&  apt-get -y install locales \
  &&  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  &&  locale-gen \
  &&  apt-get -y install tmux \
  &&  apt-get -y install vim \
  &&  apt-get -y install zsh

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
  &&  chsh -s /bin/zsh

COPY ".bashrc" "/root/.bashrc"
COPY ".zshrc" "/root/.zshrc"
COPY ".tmux.config" "/root/.tmux.config"

#RUN tmux | true && tmux source-file /root/.tmux.config
