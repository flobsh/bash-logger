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

header() {
  printf "%s%s\n" "${1}" "${2}"  
}

h1() {
  header "${H1}" "${1}"
}
