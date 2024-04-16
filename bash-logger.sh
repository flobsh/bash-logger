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

# Check the presence of a dependency
#
# usage:
#   $0 <path> <description>
#
# args:
#   $1 <path>: Path to the dependency.
#   $2 <description>: Description of the dependency. If the dependency is not found,
#                     this is used in the error message like this:
#                     `error: <description> not found, expected path is <path>`.
_check_dependency() {
  local -r path="${1}"
  local -r description="${2}"

  if ! [[ -f "${path}" ]]; then
    printf "error: ${description} not found, expected path is %s" "${path}\n" >&2
    exit 1
  fi
}

[[ "${LOG_FORMATTING}" = true ]] && _check_dependency "${FORMATSHEET_PATH}" "format sheet"
_check_dependency "${STYLESHEET_PATH}" "stylesheet"
_check_dependency "${SUBCOMMANDS_PATH}" "subommands"

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

# Main log function
# Print a message on stdout or stderr, with a pre-defined style
#
# usage:
#   log <subcommand> <content>
#
# args:
#   $1 <subcommand>: Defines behavior of the log function (style, log level and output stream).
#                    See subcommands.conf.
#   $2 <content>:    Content to print.
log() {
  local -n subcommand="${LOG_COMMANDS[${1}]}"
  local content="${2}"

  # Don't do anything if the current LOG_LEVEL is lower than the log_level of the subcommand
  if [[ "${LOG_LEVELS[${subcommand[log_level]}]}" -gt "${LOG_LEVELS[${LOG_LEVEL}]}" ]]; then
    return 0
  fi

  local -n style="${subcommand[style]}"

  printf "%s%s%s%s\n" "${style[format]}" "${style[prefix]}" "${content}" "${FORMAT_RESET}" >&"${subcommand[stream]}"
}
