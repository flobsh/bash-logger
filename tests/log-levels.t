#!/bin/bash

test_description='Test that log levels are correclty output'

. "$(dirname "${BASH_SOURCE[0]}")"/../bash-logger.sh
. "$(dirname "${BASH_SOURCE[0]}")"/sharness/sharness.sh

EXPECTED_OUTPUT="\
error: error
warning: warning
info: info
debug: debug"

# Set global options to run test:
LOG_SCRIPT_NAME=OFF
LOG_FORMATTING=OFF

# shellcheck disable=SC2317
log_diagnostics() {
  log_err "error"
  log_warn "warning"
  log_info "info"
  log_debug "debug"
}

# Test LOG_LEVEL
# $1: LOG_LEVEL
# shellcheck disable=SC2317
test_log_level() {
  local log_level="${1}"
  case "${log_level}" in
    DEBUG)
      LOG_LEVEL=DEBUG
      test "$(log_diagnostics 2>&1)" == "${EXPECTED_OUTPUT}"
      ;;
    INFO)
      LOG_LEVEL=INFO
      test "$(log_diagnostics 2>&1)" == "$(echo "${EXPECTED_OUTPUT}" | head -n 3)"
      ;;
    WARNING)
      LOG_LEVEL=WARNING
      test "$(log_diagnostics 2>&1)" == "$(echo "${EXPECTED_OUTPUT}" | head -n 2)"
      ;;
    ERROR)
      LOG_LEVEL=ERROR
      test "$(log_diagnostics 2>&1)" == "$(echo "${EXPECTED_OUTPUT}" | head -n 1)"
      ;;
    *)
      printf "unknown log level" >&2
      return 1
      ;;
  esac
}

test_expect_success 'Debug' "
  test_log_level DEBUG
"

test_expect_success 'Info' "
  test_log_level INFO
"

test_expect_success 'Warning' "
  test_log_level WARNING
"

test_expect_success 'Error' "
  test_log_level ERROR
"

test_done