#!/bin/sh

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

# Style sheet
H1="${BOLD}"
BERR="${BOLD}${RED}"
BWARN="${BOLD}${YELLOW}"
BNOTICE="${BOLD}${BLUE}"
BINFO="${BOLD}${WHITE}"
BDEBUG="${BOLD}${BLACK}"

ERR="${RED}"
WARN="${YELLOW}"
NOTICE="${BLUE}"
INFO="${WHITE}"
DEBUG="${BLACK}"

log_with_style() {
  printf "%s%s%s\n" "${1}" "${2}" "${RESET}"  
}

alias log_berr='log_with_style ${BERR}'
alias log_bwarn='log_with_style ${BWARN}'
alias log_bnotice='log_with_style ${BNOTICE}'
alias log_binfo='log_with_style ${BINFO}'
alias log_bdebug='log_with_style ${BDEBUG}'

alias log_err='log_with_style ${ERR}'
alias log_warn='log_with_style ${WARN}'
alias log_notice='log_with_style ${NOTICE}'
alias log_info='log_with_style ${INFO}'
alias log_debug='log_with_style ${DEBUG}'
