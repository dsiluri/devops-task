# Use the existing Haskell image as our base
FROM fpco/stack-build-small:lts
WORKDIR /root/.local/bin
ADD . /root/.local/bin
RUN ls -l /root/.local/bin
RUN stack setup
RUN stack test --fast --copy-bins
EXPOSE 3000
ENTRYPOINT [ “/root/.local/bin/devops-api” ]
