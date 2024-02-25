#!/bin/bash

LOG_LEVEL=${LOG_LEVEL:-INFO}

declare -r -A LOG_LEVELS=(
  [DEBUG]=0
  [INFO]=1
  [WARN]=2
  [ERR]=3
)

_log_with_level() {
  local level="${LOG_LEVELS[${1}]}"

  if [[ "${level}" -ge "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then
    printf "%s %s\n" "${1}" "${2}" >&2
  fi
}

log_debug() {
  _log_with_level DEBUG
}

log_info() {
  _log_with_level INFO
}

log_warn() {
  _log_with_level WARN
}

log_err() {
  _log_with_level ERR
}
