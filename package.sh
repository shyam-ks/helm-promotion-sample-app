#!/bin/sh
set -x
echo "Name: $1"
echo "Tag: $2"
echo "Version: $3"
echo "Comment: $4"


if [ ! -f ../package/$1-$3.tgz  ]; then

    ls
    pip install ruamel.yaml 
    python3 ./utils/update-image-tag-helm.py ./charts/$1/values.yaml $2                    
    python3 ./utils/update-chart-version.py ./charts/$1/Chart.yaml 'version' $3
              

    mkdir -p package
    cd package
    helm package ../charts/$1
    helm repo index .

    cd ..
    cd ..
    ls
    mv master/package/* package/

    cd package
    git config user.email "noreply-bn@bhge.com"
    git config user.name "helm"
    git add -A
    git diff --quiet && git diff --staged --quiet || git commit -m "Update repo [SKIP CI]" -m "$4"
    git pull
    git push 

else 
    echo "Package exists"
fi