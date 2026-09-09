# The learners build this image themselves in Activity 4.4.
# Base image: official Node runtime on Alpine Linux (small!).
FROM node:20-alpine

# Work inside a clean folder in the container.
WORKDIR /app

# Copy the dependency list FIRST and install. Docker caches this
# layer, so source edits don't re-download packages every build.
COPY package.json ./
RUN npm install

# Now copy the source.
COPY server.js ./

# The API listens on 3000.
EXPOSE 3000

# One process, started simply.
CMD ["node", "server.js"]
