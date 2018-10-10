FROM node:10.9.0-alpine

RUN apk --no-cache add bash git openssh-client docker curl \
    python py-crcmod libc6-compat gnupg

ENV CLOUD_SDK_VERSION=216.0.0
ENV PATH /google-cloud-sdk/bin:$PATH
RUN wget -O gcloud.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar zxvf gcloud.tar.gz && \
    rm gcloud.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud components install kubectl docker-credential-gcr

ENV HELM_VERSION=2.11.0
RUN wget -O helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar zxvf helm.tar.gz && \
    rm helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    helm init -c && \
    helm plugin install https://github.com/databus23/helm-diff && \
    helm version -c

# ENV HELMSMAN_VERSION=1.6.0
# RUN wget -O helmsman.tar.gz https://github.com/Praqma/helmsman/releases/download/v${HELMSMAN_VERSION}/helmsman_${HELMSMAN_VERSION}_linux_amd64.tar.gz && \
#     tar zxvf helmsman.tar.gz && \
#     rm helmsman.tar.gz && \
#     mv helmsman /usr/local/bin/helmsman && \
#     helmsman -v

# ENV SKAFFOLD_VERSION=0.14.0
# RUN wget -O skaffold https://github.com/GoogleContainerTools/skaffold/releases/download/v${SKAFFOLD_VERSION}/skaffold-linux-amd64 && \
#     chmod +x skaffold && \
#     mv skaffold /usr/local/bin/skaffold && \
#     skaffold version

ENV HELMFILE_VERSION=0.40.1
RUN wget -O helmfile https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    chmod +x helmfile && \
    mv helmfile /usr/local/bin/helmfile && \
    helmfile --version

COPY scripts /usr/local/bin/