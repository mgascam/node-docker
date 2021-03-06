FROM node:12.8.1 as base
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]

FROM base as test 
RUN npm ci
COPY . .
RUN npm run test

FROM base as prod
ENV NODE_ENV=production
RUN npm ci --production
COPY . .
CMD ["node", "server.js"]
