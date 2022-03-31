FROM node:16-alpine as build-repo

WORKDIR /usr/app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build



FROM nginx:1.21-alpine

COPY --from=build-repo /usr/app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


