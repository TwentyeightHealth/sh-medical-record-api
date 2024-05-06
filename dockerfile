FROM node:16-alpine3.18
WORKDIR /usr/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8000
RUN npm run build
CMD ["node", "dist/app.js"]