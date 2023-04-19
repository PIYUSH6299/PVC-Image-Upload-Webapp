#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED createClusterIfNeeded.sh ***
***************
'
    echo "An error occurred in createClusterIfNeeded.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e
# TODO: this script is broken.
# TODO: Check gCloud has the cluster. If present then delete.
unset DOCKER_HOST
unset DOCKER_TLS_VERIFY
unset DOCKER_TLS_PATH
CLUSTERNAME=image-upload

# kubectl config get-contexts -o name | grep translator-app | wc -c)

CLUSTER_FOUND=$(kubectl config get-contexts -o name | grep $CLUSTERNAME | wc -c)
echo "Should i create -" $CLUSTER_FOUND " with name " $CLUSTERNAME
if [[ CLUSTER_FOUND -ne 0 ]]; then
	echo "Cluster Exists. NO Need to be created."${CLUSTERNAME};
else
	# DONE: It is now coming here.
	echo "Cluster Does not exit. Need to be created.";
	echo "gcloud container clusters create $CLUSTERNAME --num-nodes=2"
	gcloud container clusters create $CLUSTERNAME --zone us-east1-b 
fi

trap : 0

echo >&2 '
************
*** DONE createClusterIfNeeded ***
************'