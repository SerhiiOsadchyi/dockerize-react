FROM node:18-alpine AS build

WORKDIR /myapp

COPY ./my-react-app/ .

RUN npm install && npm run build

FROM nginx:stable-alpine3.20-perl

COPY --from=build /myapp/build /var/www/myapp
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
