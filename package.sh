#!/bin/sh
set -x
echo "Name: $1"
echo "Version: $2"

ls
pip install ruamel.yaml                    
python3 ./utils/update-chart-version.py ./chart/$1/Chart.yaml 'version' $2

mkdir -p package
cd package
helm package ../chart/*
helm repo index .

cd ..
cd ..
ls
mv master/package/* package/

 