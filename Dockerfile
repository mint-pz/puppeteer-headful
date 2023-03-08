FROM node:14.3.0

LABEL "repository"="https://github.com/djp3/puppeteer-headful"

#Install chromium and xvfb
RUN  apt-get update \
     && apt-get install -yq chromium \
     && apt-get install -y wget xvfb --no-install-recommends 

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

COPY README.md /

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
