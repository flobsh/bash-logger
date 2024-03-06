#!/bin/bash

test_description='Test that script name is correctly reported'

. "$(dirname "${BASH_SOURCE[0]}")"/../bash-logger.sh
. "$(dirname "${BASH_SOURCE[0]}")"/sharness/sharness.sh

# Set global options to run test:
LOG_LEVEL=DEBUG
LOG_FORMATTING=OFF
TEST_SCRIPT_NAME="$(basename "${0}")"

test_log() {
  log_section "section"
  log "normal"
  log_err "error"
  log_warn "warning"
  log_info "info"
  log_debug "debug"
}

test_log_script_name() {
  local log_script_name="${1}"

  if [[ "${log_script_name}" = true ]]; then
    LOG_SCRIPT_NAME=true
    test "$(test_log 2>&1)" ==  "\
section
normal
[${TEST_SCRIPT_NAME}] error: error
[${TEST_SCRIPT_NAME}] warning: warning
[${TEST_SCRIPT_NAME}] info: info
[${TEST_SCRIPT_NAME}] debug: debug"
  else
    LOG_SCRIPT_NAME=false
    test "$(test_log 2>&1)" ==  "\
section
normal
error: error
warning: warning
info: info
debug: debug"
  fi
}

test_expect_success 'LOG_SCRIPT_NAME=false' '
  test_log_script_name false
'
test_log_script_name DEBUG

test_expect_success 'LOG_SCRIPT_NAME=true' '
  test_log_script_name true
'

test_done
