#!/bin/bash

declare -r -x -A ERROR=(
  [prefix]="error: "
)

declare -r -x -A WARNING=(
  [prefix]="warning: "
)

declare -r -x -A INFO=(
  [prefix]="info: "
)

declare -r -x -A DEBUG=(
  [prefix]="debug: "
)
