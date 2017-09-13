FROM node:7
WORKDIR /app
COPY package.json ./
RUN npm install --no-color
COPY app.js ./
COPY static ./static/
CMD node app.js