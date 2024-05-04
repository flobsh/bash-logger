#!/bin/bash

TEST_DIR="."

test_result=0

for test in "${TEST_DIR}"/*.t; do
  echo "=== Running $(basename "${test}") ==="
  if ! ./"${test}" --verbose; then
    test_result=1
  fi
done

exit $test_result
