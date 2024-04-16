#!/bin/bash

test_description='Test that styles output to the correct stream'

# Set global options to run test:
LOG_LEVEL=DEBUG
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

# Test output stream
# $1: stream
# shellcheck disable=SC2317
test_stream() {
  local stream="${1}"
  case "${stream}" in
    1)
      test "$(test_log 2> /dev/null)" == "$(echo "${EXPECTED_OUTPUT}" | head -n 2)"
      ;;
    2)
      test "$({ test_log 1> /dev/null; } 2>&1)" == "$(echo "${EXPECTED_OUTPUT}" | tail -n 4)"
      ;;
    *)
      printf "unknown stream" >&2
      return 1
      ;;
  esac
}

test_expect_success 'Output to stdout' "
  test_stream 1
"

test_expect_success 'Output to stderr' "
  test_stream 2
"

test_done
