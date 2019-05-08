# Install the activation script
mkdir -p ${PREFIX}/etc/conda/activate.d
mkdir -p ${PREFIX}/etc/conda/deactivate.d
cp ${RECIPE_DIR}/enable-gsutil-env.sh ${PREFIX}/etc/conda/activate.d/
cp ${RECIPE_DIR}/disable-gsutil-env.sh ${PREFIX}/etc/conda/deactivate.d/
