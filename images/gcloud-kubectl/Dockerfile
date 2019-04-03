FROM alpine/helm:2.13.1 AS helm


FROM google/cloud-sdk:alpine

RUN gcloud components update && \
    gcloud components install kubectl

COPY --from=helm /usr/bin/helm /usr/bin/helm

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
