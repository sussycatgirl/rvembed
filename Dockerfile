FROM node:16 AS build
WORKDIR /build/
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM node:16 as prod
WORKDIR /app/
COPY --from=build /build/package.json /build/yarn.lock /build/views ./
COPY --from=build /build/dist ./dist
RUN yarn install --production --frozen-lockfile
CMD ["yarn", "start"]