#!/bin/bash

test_description='Test that subcommands output to the correct stream'

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
log_all_subcmds() {
  log section "section"
  log normal "normal"
  log error "error"
  log warning "warning"
  log info "info"
  log debug "debug"
}

# Test stderr stream
# shellcheck disable=SC2317
test_stderr_output() {
  test "$({ log_all_subcmds 1> /dev/null; } 2>&1)" = "$(echo "${EXPECTED_OUTPUT}" | tail -n 4)"
}

# shellcheck disable=SC2016
test_expect_success 'Output to stdout' '
  echo "${EXPECTED_OUTPUT}" | head -n 2 > expected
  log_all_subcmds 1> actual 2> /dev/null
  test_cmp expected actual
'

# shellcheck disable=SC2016
test_expect_success 'Output to stderr' '
  echo "${EXPECTED_OUTPUT}" | tail -n 4 > expected
  log_all_subcmds 2> actual 1> /dev/null
  test_cmp expected actual
'

test_done
