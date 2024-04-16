#!/bin/bash

# GLOBAL OPTIONS
# LOG_LEVEL sets the level of log the script will output.
# The logger will display the messages for LOG_LEVEL and higher.
# Values can be DEBUG, INFO, WARNING or ERROR (default INFO).
LOG_LEVEL=${LOG_LEVEL:-INFO}

# LOG_SCRIPT_NAME enables display of the script issuing the log.
# Values can be (default true):
# - true: the logger will display the script's name if the style
#         allows it with the [script-name]=true key.
# - false: the logger will never display the script's name
LOG_SCRIPT_NAME=${LOG_SCRIPT_NAME:-false}

# LOG_FORMATTING enables output colors and text formatting
# Values can be true or false (default true)
LOG_FORMATTING=${LOG_FORMATTING:-true}

# DEPENDENCIES
FORMATSHEET_PATH="$(dirname "${BASH_SOURCE[0]}")/formatting.conf"
STYLESHEET_PATH="$(dirname "${BASH_SOURCE[0]}")/styles.conf"
SUBCOMMANDS_PATH="$(dirname "${BASH_SOURCE[0]}")/subcommands.conf"

# Check dependencies presence
_check_dependencies() {
  if [[ "${LOG_FORMATTING}" = true ]] && ! [[ -f "${FORMATSHEET_PATH}" ]]; then
    printf "error: format sheet not found, expected path is %s" "${FORMATSHEET_PATH}\n" >&2
    exit 1
  fi
  if ! [[ -f "${STYLESHEET_PATH}" ]]; then
    printf "error: stylesheet not found, expected path is %s" "${STYLESHEET_PATH}\n" >&2
    exit 1
  fi
  if ! [[ -f "${SUBCOMMANDS_PATH}" ]]; then
    printf "error: subcommands file not found, expected path is %s" "${SUBCOMMANDS_PATH}\n" >&2
    exit 1
  fi
}

_check_dependencies

# Source configuration files
# shellcheck source=formatting.conf
[[ "${LOG_FORMATTING}" = true ]] && . "${FORMATSHEET_PATH}"
# shellcheck source=styles.conf
. "${STYLESHEET_PATH}"
# shellcheck source=subcommands.conf
. "${SUBCOMMANDS_PATH}"

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
# $3: output stream (number)
_log() {
  # Arguments
  local -n style="${1}"
  local content="${2}"

  # Local variables
  local script_name=""
  local prefix="${style[prefix]}"
  local format="${style[format]}"
  local stream="${style[stream]:-1}"
  local log_level="${style[log_level]:-ANY}"

  if [[ "${LOG_LEVELS[${style[log_level]:-ANY}]}" -gt "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then
    return 0
  fi

  # Check if script name should be displayed.
  if [[ "${LOG_SCRIPT_NAME}" = true ]] && [[ "${style[script_name]}" = true ]]; then
    script_name="[$(_get_caller_script_name)] "
  fi

  printf "%s%s%s%s%s\n" "${format}" "${script_name}" "${prefix}" "${content}" "${FORMAT_RESET}" >&"${stream}"
}

log_subcmd() {
  local -n subcommand="${LOG_COMMANDS[${1}]}"
  local content="${2}"

  # Don't do anything if the current LOG_LEVEL is lower than the log_level of the subcommand
  if [[ "${LOG_LEVELS[${subcommand[log_level]}]}" -gt "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then
    return 0
  fi

  local -n style="${subcommand[style]}"

  printf "%s%s%s%s\n" "${style[format]}" "${style[prefix]}" "${content}" "${FORMAT_RESET}" >&"${subcommand[stream]}"
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
