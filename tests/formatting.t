#!/bin/bash

test_description='Test that log levels are correclty outputed'

# Set global options to run test:
LOG_LEVEL=DEBUG
LOG_FORMATTING=true

. "$(dirname "${BASH_SOURCE[0]}")"/../bash-logger.sh
. "$(dirname "${BASH_SOURCE[0]}")"/sharness/sharness.sh

EXPECTED_OUTPUT="\
\e[37mnormal\e(B\e[m
\e[1m\e[34msection\e(B\e[m
\e[31merror: error\e(B\e[m
\e[33mwarning: warning\e(B\e[m
\e[37minfo: info\e(B\e[m
\e[30mdebug: debug\e(B\e[m"

log_all_subcmd() {
  log normal "normal"
  log section "section"
  log error "error"
  log warning "warning"
  log info "info"
  log debug "debug"
}

test_expect_success 'Formatting' "
  echo -e '${EXPECTED_OUTPUT}' > expected
  log_all_subcmd &> actual
  test_cmp expected actual
"

test_done
