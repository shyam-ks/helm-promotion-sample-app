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
mv master/package/* package/
cd package
git config user.email "random@bhge.com"
git config user.name "weknowthe"
git add -A
git diff --quiet && git diff --staged --quiet || git commit -m "Update repo [SKIP CI]" -m "${{ github.event.head_commit.message }}"
git push  