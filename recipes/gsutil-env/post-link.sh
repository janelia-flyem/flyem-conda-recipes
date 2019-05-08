#!/bin/bash

GSUTIL_ENV=$(dirname ${PREFIX})/gsutil-env

if [[ "${PREFIX}" == "$(conda info --root)" ]]; then
    2>&1 echo "Can't install gsutil-env package with the root conda environment!"
    exit 1 
fi

# Make sure the environment exists, but otherwise don't update it or anything.
if [ ! -e ${GSUTIL_ENV} ]; then

    conda create -y -p ${GSUTIL_ENV} python=2.7
    ${GSUTIL_ENV}/bin/pip install gsutil
fi
