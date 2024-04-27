#!/bin/bash

TEST_DIR="."

for test in "${TEST_DIR}"/*.t; do
  echo "=== Running $(basename "${test}") ==="
  ./"${test}" --verbose
done
