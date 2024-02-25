#!/bin/bash

. "$(dirname "${0}")"/../bash-logger.sh

LOG_LEVEL_OUTPUTS="\
ERR error
WARN warning
INFO info
DEBUG debug"

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
LOG_LEVEL=WARN
assert_eq "$(log_diagnostics 2>&1)" "$(echo "${LOG_LEVEL_OUTPUTS}" | head -n 2)"
LOG_LEVEL=ERR 
assert_eq "$(log_diagnostics 2>&1)" "$(echo "${LOG_LEVEL_OUTPUTS}" | head -n 1)"
