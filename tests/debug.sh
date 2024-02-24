#!/bin/sh

. "$(dirname "${0}")"/../logger.sh

print() {
  printf "%s%s%s\n" "${1}" "${2}" "${RESET}"
}

# Format test
echo "-- Test: formatting"
print "${BOLD}" "bold"
print "${ULINE}" "underline"
print "${BLINK}" "blinking"
print "${DIM}" "dimmed"
print "${ITALIC}" "italic"
printf "\n"

# Colors test
echo "-- Test: colors"
print "${BLACK}" "black"
print "${RED}" "red"
print "${GREEN}" "green"
print "${YELLOW}" "yellow"
print "${BLUE}" "blue"
print "${MAGENTA}" "magenta"
print "${CYAN}" "cyan"
print "${WHITE}" "white"
printf "\n"

# Log functions tests
echo "-- Test: log functions"
log_berr "bold error"
log_bwarn "bold warning"
log_bnotice "bold notice"
log_binfo "bold info"
log_bdebug "bold debug"

log_err "error"
log_warn "warning"
log_notice "notice"
log_info "info"
log_debug "debug"
