# What image do you want to start building on?
FROM node:12-alpine
ENV NODE_ENV production
# Make a folder in your image where your app's source code can live
RUN mkdir -p /usr/src/app
# Tell your container where your app's source code will live
WORKDIR /usr/src/app
# What source code do you what to copy, and where to put it?
# COPY . /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
# Does your app have any dependencies that should be installed?
RUN npm install --production --silent && mv node_modules ../
COPY . .
# RUN npm run build:bundle # maybe i'll try this out later
# What port will the container talk to the outside world with once created?
EXPOSE 3003
# How do you start your app?
CMD npm start

# What image do you want to start building on?
# Make a folder in your image where your app's source code can live
# Tell your container where your app's source code will live
# What source code do you what to copy, and where to put it?
# Does your app have any dependencies that should be installed?
# What port will the container talk to the outside world with once created?
# How do you start your app?
