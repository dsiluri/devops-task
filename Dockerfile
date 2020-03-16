# Use the existing Haskell image as our base
FROM haskell:8.8.3
RUN stack setup
RUN stack init
RUN stack build
RUN stack exec devops-api
EXPOSE 3000
CMD [“run-server”]
