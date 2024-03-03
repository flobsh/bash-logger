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

log "${MAGENTA}Customize ${CYAN}colors ${GREEN}within ${YELLOW}log ${BLUE}functions.${RESET}"
log "${BOLD}Or${RESET} ${ITALIC}even${RESET} ${DIM}use${RESET} ${BLINK}formatting${RESET} ${ULINE}options.${RESET}"
echo -e

log "Try running this script with LOG_LEVEL=DEBUG, LOG_FORMATTING=OFF or LOG_SCRIPT_NAME=ERROR"

