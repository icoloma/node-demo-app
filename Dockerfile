FROM node:7
WORKDIR /app
COPY package.json ./
RUN npm install --no-color
COPY static app.js ./
CMD node app.js