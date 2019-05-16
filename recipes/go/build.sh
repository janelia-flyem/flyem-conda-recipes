#!/bin/bash

# Simply copy the entire tarball contents into the PREFIX
mkdir -p ${PREFIX}/go
cp -r * ${PREFIX}/go

# The vendored pprof package includes a test suite that
# contains intentionally "malformed" Mach-O and ELF binaries.
#
# Unfortunately, conda-build discovers those files and tries to analyze them, which crashes.
# We don't need to run the pprof test suite, so just remove those "malformed" files.
rm ${PREFIX}/go/src/cmd/vendor/github.com/google/pprof/internal/binutils/testdata/malformed_*

# Symlink everything from go/bin directly into bin
mkdir -p ${PREFIX}/bin
cd ${PREFIX}/bin
for f in ${PREFIX}/go/bin/*; do
  ln -s $f
done
cd -

# Install activation script (sets GOROOT).
mkdir -p ${PREFIX}/etc/conda/activate.d
cp ${RECIPE_DIR}/activate-go.sh ${PREFIX}/etc/conda/activate.d
mkdir -p ${PREFIX}/etc/conda/deactivate.d
cp ${RECIPE_DIR}/deactivate-go.sh ${PREFIX}/etc/conda/deactivate.d
