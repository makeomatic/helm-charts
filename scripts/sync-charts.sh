# helm repo add makeomatic https://helm-charts.streamlayer.io
URL="helm-charts.streamlayer.io"
alias helm="docker run alpine/helm"

### generate repo
REPO_DIR=`mktemp -d`

for chart in charts/*
do
    helm package $chart --destination $REPO_DIR
done

gsutil cp gs://$URL/index.yaml $REPO_DIR/index.old

helm repo index $REPO_DIR \
    --merge $REPO_DIR/index.old \
    --url $URL

gsutil rsync -dr $REPO_DIR gs://$URL
rm -R $REPO_DIR