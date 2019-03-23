#!/usr/bin/env bash

# This script wipes unecessary storage on GCP that may incur charges. It is
# designed to be run as a daily root cron job; currently, this is via a
# dedicated GCE instance.

# GCR
repo="us.gcr.io/fredcast/app-engine-tmp/build-cache/ttl-7d/python-cache"
if command -v parallel; then
    CMD="parallel"
else
    CMD="xargs"
fi

# List and delete all images
gcloud container images list-tags \
    --format='get(digest)' \
    --quiet \
    ${repo} | "$CMD" -I {} gcloud container images delete ${repo}@{} --force-delete-tags


# GCS
gsutil ls | "$CMD" -I{} gsutil rm -r {}

# App Engine (versions)
NUM_VERSIONS=$(gcloud app versions list | awk 'END{ print NR-1 }')
# do something to keep the latest 7, including the one(s) actively serving traffic
