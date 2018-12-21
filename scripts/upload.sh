# helm repo add makeomatic https://helm-charts.streamlayer.io
URL="helm-charts.streamlayer.io"

### generate repo
REPO_DIR=`mktemp -d`
for chart in charts/*
do
    helm package $chart --destination $REPO_DIR
done

# NOTE: is merge work with remote urls? dunno
helm repo index $REPO_DIR \
    --merge ${URL}/index.yaml \
    --url $URL

gsutil rsync -dr $REPO_DIR gs://$URL
rm -R $REPO_DIR