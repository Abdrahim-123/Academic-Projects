#!/bin/bash

required_items=("main.c" "lexical.l" "my-output" "test/in" "test/out" "check_files.sh" "run_tests.sh")
missing=0

echo "Checking required files and folders..."

for item in "${required_items[@]}"; do
  if [ ! -e "$item" ]; then
    echo "Missing: $item"
    missing=1
  else
    echo "Found: $item"
  fi
done

if [ $missing -ne 0 ]; then
  echo "Check failed: One or more required files/folders are missing."
  exit 1
else
  echo "All required files/folders are present."
fi

