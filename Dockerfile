FROM node:14.21.3

LABEL "repository"="https://github.com/djp3/puppeteer-headful"

#Install chromium and xvfb
RUN  apt-get update \
     && apt-get install -yq chromium \
     && apt-get install -y wget xvfb --no-install-recommends 

# RUN apt-get update \
#     && apt-get install -y wget gnupg \
#     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#     && apt-get update \
#     && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
#       --no-install-recommends \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get install -y wget xvfb --no-install-recommends 

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

COPY README.md /

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
