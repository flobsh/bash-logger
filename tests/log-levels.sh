#!/bin/bash

. "$(dirname "${0}")"/../bash-logger.sh

# Set global options to run test:
LOG_LEVEL=DEBUG
LOG_SCRIPT_NAME=OFF
LOG_FORMATTING=OFF

LOG_LEVEL_OUTPUTS="\
error: error
warning: warning
info: info
debug: debug"

assert_eq() {
  local got="${1}"
  local expected="${2}"

  if [[ "${got}" == "${expected}" ]]; then
    echo "PASSED"
  else
    echo "FAILED"
    printf "Got:\n%s\n\nExpected:\n%s\n" "${got}" "${expected}"
  fi
}

log_diagnostics() {
  log_err "error"
  log_warn "warning"
  log_info "info"
  log_debug "debug"
}

LOG_LEVEL=DEBUG 
assert_eq "$(log_diagnostics 2>&1)" "${LOG_LEVEL_OUTPUTS}"
LOG_LEVEL=INFO 
assert_eq "$(log_diagnostics 2>&1)" "$(echo "${LOG_LEVEL_OUTPUTS}" | head -n 3)"
LOG_LEVEL=WARNING
assert_eq "$(log_diagnostics 2>&1)" "$(echo "${LOG_LEVEL_OUTPUTS}" | head -n 2)"
LOG_LEVEL=ERROR 
assert_eq "$(log_diagnostics 2>&1)" "$(echo "${LOG_LEVEL_OUTPUTS}" | head -n 1)"
