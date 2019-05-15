mkdir -p ${PREFIX}/go
cp -r * ${PREFIX}/go
mkdir -p ${PREFIX}/bin

cd ${PREFIX}/bin
for f in ${PREFIX}/go/bin/*; do
ln -s $f
done
cd -

mkdir -p ${PREFIX}/etc/conda/activate.d
cp ${RECIPE_DIR}/activate-go.sh ${PREFIX}/etc/conda/activate.d
mkdir -p ${PREFIX}/etc/conda/deactivate.d
cp ${RECIPE_DIR}/deactivate-go.sh ${PREFIX}/etc/conda/deactivate.d
