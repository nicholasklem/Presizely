FROM perl:latest

RUN apt-get update && apt-get install -y build-essential cpanminus libjpeg-dev libjpeg62-turbo libjpeg62-turbo-dev libpng-dev libpng12-0 libgif-dev libgif4 wget unzip openssl libssl-dev && apt-get clean

RUN cpanm Config::JFDI \
          File::Share \
          FindBin \
          Moose \
          namespace::autoclean \
          Mojolicious \
          IO::Compress::Gzip \
          CHI \
          Digest::SHA \
          Imager \
          YAML::XS \
          IO::Socket::SSL

RUN mkdir -p /app

WORKDIR /app

RUN wget https://github.com/toreau/Presizely/archive/master.zip && unzip master.zip && rm master.zip

WORKDIR /app/Presizely-master

EXPOSE 3000

ENV MOJO_MAX_MESSAGE_SIZE=33554432

CMD ./script/presizely prefork -m production -w 32 -c 2
