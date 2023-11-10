FROM node:16.19-bullseye

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json ./
COPY package-lock.json ./
RUN npm install --force

COPY . .

CMD ["npm", "start"]