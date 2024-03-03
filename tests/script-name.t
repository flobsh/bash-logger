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
  case "${log_script_name}" in
    OFF)
      LOG_SCRIPT_NAME=OFF
      test "$(test_log 2>&1)" ==  "\
section
normal
error: error
warning: warning
info: info
debug: debug"
      ;;
    DEBUG)
      LOG_SCRIPT_NAME=DEBUG
      test "$(test_log 2>&1)" ==  "\
section
normal
[${TEST_SCRIPT_NAME}] error: error
[${TEST_SCRIPT_NAME}] warning: warning
[${TEST_SCRIPT_NAME}] info: info
[${TEST_SCRIPT_NAME}] debug: debug"
      ;;
    INFO)
      LOG_SCRIPT_NAME=INFO
      test "$(test_log 2>&1)" ==  "\
section
normal
[${TEST_SCRIPT_NAME}] error: error
[${TEST_SCRIPT_NAME}] warning: warning
[${TEST_SCRIPT_NAME}] info: info
debug: debug"
      ;;
    WARNING)
      LOG_SCRIPT_NAME=WARNING
      test "$(test_log 2>&1)" ==  "\
section
normal
[${TEST_SCRIPT_NAME}] error: error
[${TEST_SCRIPT_NAME}] warning: warning
info: info
debug: debug"
      ;;
    ERROR)
      LOG_SCRIPT_NAME=ERROR
      test "$(test_log 2>&1)" ==  "\
section
normal
[${TEST_SCRIPT_NAME}] error: error
warning: warning
info: info
debug: debug"
      ;;
    ON)
      LOG_SCRIPT_NAME=ON
      test "$(test_log 2>&1)" ==  "\
[${TEST_SCRIPT_NAME}] section
[${TEST_SCRIPT_NAME}] normal
[${TEST_SCRIPT_NAME}] error: error
[${TEST_SCRIPT_NAME}] warning: warning
[${TEST_SCRIPT_NAME}] info: info
[${TEST_SCRIPT_NAME}] debug: debug"
      ;;
    *)
      printf "unknown log level" >&2
      return 1
      ;;
    esac
}

test_expect_success 'LOG_SCRIPT_NAME=OFF' '
  test_log_script_name OFF
'
test_log_script_name DEBUG

test_expect_success 'LOG_SCRIPT_NAME=DEBUG' '
  test_log_script_name DEBUG
'

test_expect_success 'LOG_SCRIPT_NAME=INFO' '
  test_log_script_name INFO
'

test_expect_success 'LOG_SCRIPT_NAME=WARNING' '
  test_log_script_name WARNING
'

test_expect_success 'LOG_SCRIPT_NAME=ERROR' '
  test_log_script_name ERROR
'

test_expect_success 'LOG_SCRIPT_NAME=ON' '
  test_log_script_name ON
'

test_done
