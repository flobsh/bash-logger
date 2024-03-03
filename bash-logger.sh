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
LOG_SCRIPT_NAME=${LOG_SCRIPT_NAME:-DEBUG}
# LOG_FORMATTING enables output colors and text formatting
# Values can be ON or OFF (default ON)
LOG_FORMATTING=${LOG_FORMATTING:-ON}

. "$(dirname "${BASH_SOURCE[0]}")"/styles.conf

declare -r -A LOG_LEVELS=(
  [DEBUG]=0
  [INFO]=1
  [WARNING]=2
  [ERROR]=3
)

# Main log function.
# $1: should log script name (boolean)
# $2: style (on of the styles available in styles.sh)
# $3: content (string)
_log() {
  local log_script_name="${1}"
  local -n style="${2}"
  local content="${3}"

  # Check if script name should be displayed.
  local script_name=""
  if [[ "${log_script_name}" = true ]]; then
    script_name="[$(basename "${BASH_SOURCE[-1]}")] "
  fi

  # Check if formatting should be enabled
  local formatting=""
  local format_reset=""
  if [[ "${LOG_FORMATTING}" == ON ]]; then
    formatting="${style[format]}"
    format_reset="${RESET}"
  fi

  printf "%s%s%s%s%s\n" "${formatting}" "${script_name}" "${style[prefix]}" "${content}" "${format_reset}"
}

# Log a diagnostic message on stderr.
# $1: log level (among LOG_LEVELS)
# $2: content (string)
_log_diagnostic() {
  local level="${LOG_LEVELS[${1}]}"
  if [[ "${level}" -ge "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then

    local log_script_name
    if [[ "${LOG_SCRIPT_NAME}" == "OFF" ]]; then
      log_script_name=false
    elif [[ "${LOG_SCRIPT_NAME}" == "ON" ]] || [[ "${level}" -ge "${LOG_LEVELS[${LOG_SCRIPT_NAME}]}" ]]; then
      log_script_name=true
    fi

    _log "${log_script_name}" "${1}" "${2}" >&2
  fi
}

_log_out() {
  local style="${1}"
  local content="${2}"

  local log_script_name
  log_script_name="$([[ "${LOG_SCRIPT_NAME}" == "ON" ]] && echo true || echo false)"

  _log "${log_script_name}" "${style}" "${content}"
}

log() {
  _log_out NORMAL "${1}"
}

log_section() {
  _log_out SECTION "${1}"
}

log_debug() {
  _log_diagnostic DEBUG "${1}"
}

log_info() {
  _log_diagnostic INFO "${1}"
}

log_warn() {
  _log_diagnostic WARNING "${1}"
}

log_err() {
  _log_diagnostic ERROR "${1}"
}
