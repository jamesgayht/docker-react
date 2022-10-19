# specify the base image
FROM node:16-alpine as builder

# specify the wd to prevent any overriding
WORKDIR '/app'

# set up the package.json file for copying dependencies
COPY ./package.json ./
RUN npm install
COPY ./ ./

RUN npm run build

# select the base image for the second phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

