#!/bin/bash

set -e

GSUTIL_ENV=$(dirname ${PREFIX})/gsutil-env

# gsutil should exist
[ -e "${GSUTIL_ENV}/bin/gsutil" ]

# gsutil is on PATH, and it's the one we installed.
[[ "$(which gsutil)" == "${GSUTIL_ENV}/bin/gsutil" ]]
