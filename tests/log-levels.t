#!/bin/bash

test_description='Test that log levels are correclty output'

# Set global options to run test:
LOG_SCRIPT_NAME=false
LOG_FORMATTING=false

. "$(dirname "${BASH_SOURCE[0]}")"/../bash-logger.sh
. "$(dirname "${BASH_SOURCE[0]}")"/sharness/sharness.sh

EXPECTED_OUTPUT="\
section
normal
error: error
warning: warning
info: info
debug: debug"

# shellcheck disable=SC2317
test_log() {
  log section "section"
  log normal "normal"
  log error "error"
  log warning "warning"
  log info "info"
  log debug "debug"
}

# Test LOG_LEVEL
# $1: LOG_LEVEL
# shellcheck disable=SC2317
test_log_level() {
  local log_level="${1}"
  LOG_LEVEL="${log_level}"

  test_log > actual 2>&1
  case "${log_level}" in
    DEBUG)
      echo "${EXPECTED_OUTPUT}" > expected
      ;;
    INFO)
      echo "${EXPECTED_OUTPUT}" | head -n 5 > expected
      ;;
    WARNING)
      echo "${EXPECTED_OUTPUT}" | head -n 4 > expected
      ;;
    ERROR)
      echo "${EXPECTED_OUTPUT}" | head -n 3 > expected
      ;;
  esac
  test_cmp expected actual
}

test_expect_success 'Debug' '
  test_log_level DEBUG
'

test_expect_success 'Info' '
  test_log_level INFO
'

test_expect_success 'Warning' '
  test_log_level WARNING
'

test_expect_success 'Error' '
  test_log_level ERROR
'

test_done
