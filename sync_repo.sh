#!/bin/sh
mkdir -p package
cd package
helm package ../chart/*
helm repo index .
