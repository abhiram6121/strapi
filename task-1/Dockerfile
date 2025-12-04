FROM node:22-slim

# Installing libvips-dev for sharp Compatibility
RUN apt-get update && apt-get install -y libvips-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN ["npm", "run", "build"]

EXPOSE 1337
CMD ["npm", "run", "develop"]
