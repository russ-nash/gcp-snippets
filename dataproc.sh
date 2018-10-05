#!bash

## Dataproc - Zeppelin - AU - 1 Master 2 Workers
  gcloud dataproc  clusters create cluster-zepp2 \
  --bucket $BUCKET \
  --subnet default \
  --zone australia-southeast1-a \
  --master-machine-type n1-standard-2 \
  --master-boot-disk-size 500 \
  --num-workers 2 \
  --worker-machine-type n1-standard-1 \
  --worker-boot-disk-size 500 \
  --image-version 1.2 \
  --scopes 'https://www.googleapis.com/auth/cloud-platform' \
  --project $PROJECT \
  --initialization-actions 'gs://dataproc-initialization-actions/zeppelin/zeppelin.sh' \
  --image-version=1.3-deb9
  
  
# Dataproc - Setup SOCKS Proxy
gcloud compute ssh cluster-zepp1-m \
    --project=$PROJECT --zone=australia-southeast1-a  -- -D 1080 -N
    
# Startup Chrome using Proxy
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --proxy-server="socks5://localhost:1080" \
  --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost" \
  --user-data-dir=/tmp/cluster-zepp1-m
  
