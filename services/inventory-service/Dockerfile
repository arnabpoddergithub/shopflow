FROM node:18-slim AS base

WORKDIR /app

COPY package.json .
RUN npm install

FROM base AS final

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]
