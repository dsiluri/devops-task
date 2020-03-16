# Use the existing Haskell image as our base
FROM fpco/stack-build-small:lts
WORKDIR /root/.local/bin
ADD . /root/.local/bin
RUN ls -l /root/.local/bin
RUN stack setup
RUN stack build
RUN stack test
RUN stack exec devops-api
EXPOSE 3000
CMD [“run-server”]
