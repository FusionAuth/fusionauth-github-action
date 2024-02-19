#!/bin/sh -l

echo "Hello FA $1"
time=$(date)
echo "::set-output name=time::$time"