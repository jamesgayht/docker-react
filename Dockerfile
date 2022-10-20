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
# expose instrcution is mostly for communication between developers, in the case of elastic beanstalk it will take this documentation and map to port 80
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

