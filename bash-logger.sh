#!/bin/bash

. "$(dirname "${BASH_SOURCE[0]}")"/styles.sh

LOG_LEVEL=${LOG_LEVEL:-INFO}

declare -r -A LOG_LEVELS=(
  [DEBUG]=0
  [INFO]=1
  [WARN]=2
  [ERR]=3
)

_log() {
  local -n style="${1}"

  if [[ "${level}" -ge "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then
    printf "%s%s\n" "${style[prefix]}" "${2}"
  fi
}

_log_with_level() {
  local level="${LOG_LEVELS[${1}]}"

  if [[ "${level}" -ge "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then
    _log "${1}" "${2}" >&2
  fi
}

log_debug() {
  _log_with_level DEBUG "${1}"
}

log_info() {
  _log_with_level INFO "${1}"
}

log_warn() {
  _log_with_level WARN "${1}"
}

log_err() {
  _log_with_level ERR "${1}"
}
