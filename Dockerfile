FROM node AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
WORKDIR /usr/bin/app
USER node
COPY --chown=node:node nginx.conf /etc/nginx/
COPY --chown=node:node --from=build /usr/src/app/dist/web/browser /usr/share/nginx/html
