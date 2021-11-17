#!/bin/sh
echo "Version: $1"

cd master
ls
pip install ruamel.yaml                    
python3 ./utils/update-chart-version.py ./chart/sample-app/Chart.yaml 'version' $1

mkdir -p package
cd package
helm package ../chart/*
helm repo index .