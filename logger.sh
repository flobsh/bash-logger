#!/bin/sh

# Formatting and color codes
BOLD="$(tput bold)"

# Style sheet
H1="${BOLD}"

header() {
  printf "%s%s\n" "${1}" "${2}"  
}

h1() {
  header "${H1}" "${1}"
}
