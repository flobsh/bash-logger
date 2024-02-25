#!/bin/bash

# Retrieve styling options
if [[ -n "${LOG_SCRIPT_NAME}" ]] && [[ "${LOG_SCRIPT_NAME}" = true ]]; then
  SCRIPT_NAME="[$(basename "${BASH_SOURCE[-1]}")] "
else
  SCRIPT_NAME=""
fi

declare -r -x -A ERR=(
  [prefix]="${SCRIPT_NAME}error: "
)

declare -r -x -A WARN=(
  [prefix]="${SCRIPT_NAME}warning: "
)

declare -r -x -A INFO=(
  [prefix]="${SCRIPT_NAME}info: "
)

declare -r -x -A DEBUG=(
  [prefix]="${SCRIPT_NAME}debug: "
)
