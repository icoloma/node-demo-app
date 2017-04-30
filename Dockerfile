FROM node:7
WORKDIR /app
COPY static static
COPY app.js package.json ./
RUN npm install --no-color
CMD node app.js