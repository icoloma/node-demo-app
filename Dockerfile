FROM node:0.12
WORKDIR /app
COPY static static
COPY app.js package.json ./
RUN npm install
CMD node app.js