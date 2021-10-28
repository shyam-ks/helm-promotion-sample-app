#!/bin/sh
mkdir -p package
cd package
helm package ../charts/*
helm repo index .
