# Use the existing Haskell image as our base
FROM haskell:8.8.3# Checkout our code onto the Docker container
WORKDIR /app
ADD . /app# Build and test our code, then install the “run-server” executable
RUN stack setup
RUN stack build --test --copy-bins# Expose a port to run our application
RUN stack exec devops-api
EXPOSE 3030# Run the server command
CMD [“run-server”]
