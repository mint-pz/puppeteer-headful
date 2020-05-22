FROM node:12.10.0

#Action meta data
LABEL "com.github.actions.name"="Puppeteer Headful"
LABEL "com.github.actions.description"="A GitHub Action / Docker image for Puppeteer, the Headful Chrome Node API"
LABEL "com.github.actions.icon"="layout"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/djp3/puppeteer-headful"
LABEL "homepage"="https://github.com/djp3/puppeteer-headful"
LABEL "maintainer"="Donald Patterson"

#Install chromium and xvfb
RUN  apt-get update \
     && apt-get install -yq chromium \
     && apt-get install -y wget xvfb --no-install-recommends 

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

COPY README.md /

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
