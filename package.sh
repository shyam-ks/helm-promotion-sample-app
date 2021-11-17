#!/bin/sh
set -x
echo "Version: $1"

ls
pip install ruamel.yaml                    
python3 ./utils/update-chart-version.py ./chart/sample-app/Chart.yaml 'version' $1

mkdir -p package
cd package
helm package ../chart/*
helm repo index .

cd ..
cd ..
ls
mv master/package/* package/
cd package
 