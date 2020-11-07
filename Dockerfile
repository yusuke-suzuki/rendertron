FROM node:15.1.0-alpine3.12

# Installs latest Chromium (85) package.
RUN apk add --no-cache \
  chromium \
  nss \
  freetype \
  freetype-dev \
  harfbuzz \
  ca-certificates \
  ttf-freefont

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
  PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /rendertron

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

ENV PORT 80
EXPOSE 80

CMD ["npm", "run", "start"]
