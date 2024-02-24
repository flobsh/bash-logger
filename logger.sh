#!/bin/sh

BOLD="$(tput bold)"
readonly BOLD

h1() {
  printf "%s%s\n" "${BOLD}" "${1}"
}
