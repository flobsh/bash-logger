#!/bin/bash

# Formatting
# shellcheck disable=SC2034
{
  RESET="$(tput sgr0)"
  BOLD="$(tput bold)"
  BLINK="$(tput blink)"
  ULINE="$(tput smul)"
  DIM="$(tput dim)"
  ITALIC="$(tput sitm)"
}

# Colors
# shellcheck disable=SC2034
{
  BLACK="$(tput setaf 0)"
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  MAGENTA="$(tput setaf 5)"
  CYAN="$(tput setaf 6)"
  WHITE="$(tput setaf 7)"
}

declare -r -A ERR=(
  [prefix]="error: "
  [suffix]=""
  [format]="${RED}"
)

declare -r -A WARN=(
  [prefix]="warning: "
  [suffix]=""
  [format]="${YELLOW}"
)

declare -r -A NOTICE=(
  [prefix]=""
  [suffix]=""
  [format]="${BLUE}"
)

declare -r -A INFO=(
  [prefix]=""
  [suffix]=""
  [format]="${WHITE}"
)

declare -r -A DEBUG=(
  [prefix]=""
  [suffix]=""
  [format]="${BLACK}"
)

declare -r -A BERR=(
  [prefix]="error: "
  [suffix]=""
  [format]="${BOLD}${RED}"
)

declare -r -A BWARN=(
  [prefix]="warning: "
  [suffix]=""
  [format]="${BOLD}${YELLOW}"
)

declare -r -A BNOTICE=(
  [prefix]=""
  [suffix]=""
  [format]="${BOLD}${BLUE}"
)

declare -r -A BINFO=(
  [prefix]=""
  [suffix]=""
  [format]="${BOLD}${WHITE}"
)

declare -r -A BDEBUG=(
  [prefix]=""
  [suffix]=""
  [format]="${BOLD}${BLACK}"
)

_log_err() {
  local -n style=$1
  printf "%s%s%s%s%s\n" "${style[format]}" "${style[prefix]}" "${2}" "${style[suffix]}" "${RESET}" >&2
}

alias log_berr='_log_err BERR'
alias log_bwarn='_log_err BWARN'
alias log_bnotice='_log_err BNOTICE'
alias log_binfo='_log_err BINFO'
alias log_bdebug='_log_err BDEBUG'

alias log_err='_log_err ERR'
alias log_warn='_log_err WARN'
alias log_notice='_log_err NOTICE'
alias log_info='_log_err INFO'
alias log_debug='_log_err DEBUG'
