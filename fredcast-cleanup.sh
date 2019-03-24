#!/usr/bin/env bash

# This script wipes unecessary storage on GCP that may incur charges. It is
# designed to be run as a daily root cron job.

if command -v parallel; then
    CMD="parallel"
else
    CMD="xargs"
fi

# GCR
IMAGE_REPO="us.gcr.io/fredcast/app-engine-tmp/build-cache/ttl-7d/python-cache"
gcloud container images list-tags \
    --format='get(digest)' \
    --quiet \
    ${IMAGE_REPO} | "$CMD" -I{} gcloud container images delete ${IMAGE_REPO}@{} --force-delete-tags

# GCS
gsutil ls | grep 'fredcast.appspot.com' | "$CMD" -I{} gsutil rm -r {}

# App Engine (versions)
NUM_VERSIONS=$(gcloud app versions list | awk 'END{ print NR-1 }')
# do something to keep the latest 7, including the one(s) actively serving traffic
