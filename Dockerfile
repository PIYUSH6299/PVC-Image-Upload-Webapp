# downloads image from docker file
FROM node:15.14.0

# set working directory in docker image
WORKDIR /app

# copy the package.json file from local to docker image under folder /app/package.json
COPY /ImageUpload-logic/package.json /app/package.json

# install the node in docker image
RUN npm install --silent

# here it copies the folder
COPY /ImageUpload-logic /app	

# port of expose is 80
EXPOSE 80

# run the node app
CMD ["npm","start", "-g", "daemon off;"]