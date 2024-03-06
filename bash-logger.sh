#!/bin/bash

# Global options
# LOG_LEVEL sets the level of log the script will output.
# The logger will display the messages for LOG_LEVEL and higher.
# Values can be DEBUG, INFO, WARNING or ERROR (default INFO).
LOG_LEVEL=${LOG_LEVEL:-INFO}
# LOG_SCRIPT_NAME enables display of the script issuing the log.
# Values can be (default DEBUG):
# - OFF: the logger will never display the script's name
# - DEBUG, INFO, WARNING or ERROR: the logger will display the script's name only for this log level and higher
# - ON: the logger will always display the script's name
LOG_SCRIPT_NAME=${LOG_SCRIPT_NAME:-false}
# LOG_FORMATTING enables output colors and text formatting
# Values can be ON or OFF (default ON)
LOG_FORMATTING=${LOG_FORMATTING:-ON}

. "$(dirname "${BASH_SOURCE[0]}")"/styles.conf

declare -r -A LOG_LEVELS=(
  [ANY]=0
  [ERROR]=1
  [WARNING]=2
  [INFO]=3
  [DEBUG]=4
)

_get_caller_script_name() {
  basename "${BASH_SOURCE[-1]}"
}

# Main log function.
# $1: style (defined in styles.conf)
# $2: content (string)
_log() {
  # Arguments
  local -n style="${1}"
  local content="${2}"

  # Local variables
  local script_name=""
  local formatting=""
  local format_reset=""

  if [[ "${LOG_LEVELS[${style[log_level]:-ANY}]}" -gt "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then
    return 0
  fi

  # Check if script name should be displayed.
  if [[ "${LOG_SCRIPT_NAME}" = true ]] && [[ "${style[script_name]}" = true ]]; then
    script_name="[$(_get_caller_script_name)] "
  fi

  # Check if formatting should be enabled
  if [[ "${LOG_FORMATTING}" == ON ]]; then
    formatting="${style[format]}"
    format_reset="${RESET}"
  fi

  printf "%s%s%s%s%s\n" "${formatting}" "${script_name}" "${style[prefix]}" "${content}" "${format_reset}"
}

log() {
  _log NORMAL "${1}"
}

log_section() {
  _log SECTION "${1}"
}

log_debug() {
  _log DEBUG "${1}"
}

log_info() {
  _log INFO "${1}"
}

log_warn() {
  _log WARNING "${1}"
}

log_err() {
  _log ERROR "${1}"
}
