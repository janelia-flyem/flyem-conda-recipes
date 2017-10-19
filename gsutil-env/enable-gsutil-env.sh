#!/bin/bash

export GSUTIL_ENV=$(dirname ${CONDA_PREFIX})/gsutil-env

# Find $CONDA_PREFIX/bin on the PATH, and insert GSUTIL_ENV/bin after it.
export PATH=$(python <(cat << EOF

from __future__ import print_function
try:
    import os
    path_items = os.environ["PATH"].split(":")
    if "$GSUTIL_ENV/bin" not in path_items:
        prefix_loc = path_items.index("$CONDA_PREFIX/bin")
        path_items.insert(prefix_loc+1, "$GSUTIL_ENV/bin")
    print(":".join(path_items), end="")
except:
    import sys
    print(os.environ["PATH"], end="")
    print("Failed to add $GSUTIL_ENV/bin to the PATH", end="", file=sys.stderr)
    raise

EOF
))
