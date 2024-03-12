#!/bin/bash

# Simple example on how to use bash-logger

. "$(dirname "${BASH_SOURCE[0]}")"/../bash-logger.sh

log_section "Attract user's attention on the main sections of your script"
log "Show information or results"
log "1 + 1 = $(( 1 + 1))"
echo -e

log_section "Log diagnostics on standard error"
log_info "Performing calculations..."
log_debug "Performing 1 + 1..."
log_warn "1 + 1 = 0?"
log_err "[[ $((1 + 1)) -eq 0 ]]"
./"$(dirname "${BASH_SOURCE[0]}")"/child.sh
log_info "And then back to $(basename "${0}") script"
echo -e

log_section "Formatting"
log "${MAGENTA}Customize ${CYAN}colors ${GREEN}within ${YELLOW}log ${BLUE}functions.${FORMAT_RESET}"
log "${BOLD}Or${FORMAT_RESET} ${ITALIC}even${FORMAT_RESET} ${DIM}use${FORMAT_RESET} ${BLINK}formatting${FORMAT_RESET} ${ULINE}options.${FORMAT_RESET}"
echo -e

log "Try running this script with LOG_LEVEL=DEBUG, LOG_FORMATTING=false or LOG_SCRIPT_NAME=true"

