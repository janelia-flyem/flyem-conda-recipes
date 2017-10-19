#!/bin/bash

GSUTIL_ENV=$(dirname ${CONDA_PREFIX})/gsutil-env

# Find $CONDA_PREFIX/bin on the PATH, and insert GSUTIL_ENV/bin after it.
export PATH=$(python <(cat << EOF

from __future__ import print_function
try:
    import os
    path_items = os.environ["PATH"].split(":")
    path_items.remove("$GSUTIL_ENV/bin")
    print(":".join(path_items), end="")    
except:
    print(os.environ["PATH"], end="")

EOF
))
