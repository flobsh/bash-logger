#!/bin/bash

declare -r -x -A ERR=(
  [prefix]="error: "
)

declare -r -x -A WARN=(
  [prefix]="warning: "
)

declare -r -x -A INFO=(
  [prefix]="info: "
)

declare -r -x -A DEBUG=(
  [prefix]="debug: "
)
