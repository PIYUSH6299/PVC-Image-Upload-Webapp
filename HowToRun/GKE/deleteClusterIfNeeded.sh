#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED deleteClusterIfNeeded.sh ***
***************
'
    echo "An error occurred in deleteClusterIfNeeded.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e
# TODO: this script is broken.
# TODO: Check gCloud has the cluster. If present then delete.
unset DOCKER_HOST
unset DOCKER_TLS_VERIFY
unset DOCKER_TLS_PATH
# INFO: https://stackoverflow.com/questions/30604846/docker-error-no-space-left-on-device
echo "INFO: Docker system pruning to save space:"
CLUSTERNAME=image-upload 
docker system prune -f

# INFO: when you try to do things parallely, then contexts will be deleted but not the cluster. 
echo "deletion of gcloud cluster is in progress...in background."
gcloud container clusters delete $CLUSTERNAME --zone us-east1-b

trap : 0

echo >&2 '
************
*** DONE deleteClusterIfNeeded ***
************'