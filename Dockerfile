FROM node:16-alpine as builder
WORKDIR /app
COPY package.json  package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

#PHASE 2: NGINX - we will copy the build folder from the previous phase

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# default command of nginx is to start the server so we don't need to specify it