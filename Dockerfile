# Use the official Haskell image to create a build artifact.
# https://hub.docker.com/_/haskell/
FROM haskell:8.8.3 as builder

# Copy local code to the container image.
WORKDIR /app
COPY . .

# Build and test our code, then build the “helloworld-haskell-exe” executable.
RUN stack setup
RUN stack build --fast -j1 --copy-bins

# Use a Docker multi-stage build to create a lean production image.
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM fpco/haskell-scratch:integer-gmp

# Copy the "devops-api" executable from the builder stage to the production image.
WORKDIR /root/
COPY --from=builder /root/.local/bin/devops-api .

# Run the web service on container startup.
CMD ["./devops-api"]
EXPOSE 3000
ENTRYPOINT [ “/root/.local/bin/devops-api” ]
