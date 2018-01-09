FROM haskell:8.0

MAINTAINER James Gregory <james@jagregory.com>

# install latex packages
RUN apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-latex-base \
    texlive-xetex latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern \
  && apt-get clean \
  && apt-get autoclean -y \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /tmp/* /var/tmp/* \
  && rm -rf /var/lib/apt/lists/*

# add google fonts
RUN mkdir ~/.fonts \
  && cd ~/.fonts \
  && apt-get update -y \
  && apt-get install -y wget unzip \
  && wget -q https://github.com/google/fonts/archive/master.zip \
  && unzip master.zip \
  && rm master.zip \
  && apt-get remove --purge -y wget unzip \
  && rm -rf /var/lib/apt/lists/*

# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
ENV PANDOC_VERSION "2.0.6"

# install pandoc
RUN cabal update && cabal install pandoc-${PANDOC_VERSION}

RUN fc-cache -fv

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]
