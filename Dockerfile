FROM node:16-alpine as build
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .
RUN npm run build

FROM nginx
# should source be absolute?
COPY --from=build /home/node/app/build /usr/share/nginx/html