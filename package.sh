#!/bin/sh
set -x
echo "Name: $1"
echo "Version: $2"
echo "Comment: $3"
echo "Tag: $3"

if [ ! -f ../package/$1-$2.tgz  ]; then

    ls
    pip install ruamel.yaml                    
    python3 ./utils/update-chart-version.py ./chart/$1/Chart.yaml 'version' $2
    python3 ./utils/update-image-tag-helm.py ./charts/$1/values.yaml                  

    mkdir -p package
    cd package
    helm package ../chart/$1
    helm repo index .

    cd ..
    cd ..
    ls
    mv master/package/* package/

    cd package
    git config user.email "noreply-bn@bhge.com"
    git config user.name "helm"
    git add -A
    git diff --quiet && git diff --staged --quiet || git commit -m "Update repo [SKIP CI]" -m "$3"
    git push 

else 
    echo "Package exists"
fi