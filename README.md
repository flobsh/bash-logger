# bash-logger

[![Shellcheck](https://github.com/flobsh/bash-logger/actions/workflows/shellcheck.yml/badge.svg?branch=main)](https://github.com/flobsh/bash-logger/actions/workflows/shellcheck.yml)

**Simple and configurable logger library for Bash scripts**

> [!IMPORTANT]
> This project is under active development, see the [Roadmap](#roadmap) section below for more information.

**bash-logger** is a simple yet highly configurable logging library for your Bash scripts. Its purpose is to provide easy-to-use logging commands to display friendly and comprehensive output.

## Usage

1. Copy the `bash-logger.sh`, `formatting.conf`, `styles.conf` and `subcommands.conf` files to a directory in your project.
These three files must be in the same directory for the default configuration to work, but if you want to have a 
different file structure, you can modify the `FORMATSHEET_PATH`, `STYLESHEET_PATH` and `SUBCOMMANDS_PATH` variables in `bash-logger.sh`.

2. Source `bash-logger.sh` in your script:
```bash
. "$(dirname "${0}")"/path/to/bash-logger.sh
```

3. Use the predefined subcommands with their associated styles or create your own:
```bash
# Use predefined subcommands
log section "Welcome to my script!"
log warning "x is not set"

# Use your own subcommand
log my-subcommand "Hello with my subcommand"
```

## Quick reference

To display messages using **bash-logger**, use the `log <subcommand> <content>` command.

### Subcommands

Subcommands are pre-configured sets of options that tell the `log` command how and when to render the content. They are defined in `subcommands.conf` in the form of associative arrays and can be customized by the developer.

Keys available for subcommands:
- `[style]`: which style to use whith this subcommand. Styles are defined in `styles.conf`
- `[stream]`: on which output stream to display the content. 1 for stdout, 2 for stderr.
- `[log_level]`: only display the content if the global `LOG_LEVEL` variable is lower than this value. Can be `DEBUG`, `INFO`, `WARNING`, `ERROR` or `ANY`.

For example:
```bash
declare -r -A LOG_CMD_MY_SUBCOMMAND=(
  [style]=LOG_STYLE_MY_STYLE
  [stream]=1
  [log_level]=INFO
)
```

Then, associate your subcommand's associative array with an easy-to-remember alias in the `LOG_COMMANDS` array:
```bash
declare -r -x -A LOG_COMMANDS=(
  # ... other subcommands
  [my-subcommand]=LOG_CMD_MY_SUBCOMMAND
)
```

This redirection is done because associative arrays are exported into the user's scripts, so we want them to have uncommon names in order not to collide with user-defined variables. The redirection allows us to refer to this complicated-named array with an easy-to-remember alias.

> [!NOTE]
> We recommend the use of `LOG_CMD_` prefix for your subcommands' associative array names.

### Styles

Styles define how the text is rendered using terminal-compatible colors and formatting options. They are defined in `styles.conf` as Bash associative arrays with the following keys:
- `[format]`: terminal-compatible escape sequences to define colors and formatting. The `formatting.conf` file provides easy-to-use variables to define your own format.
- `[prefix]`: string prepended to the message content.

For example:
```bash
declare -r -A LOG_STYLE_OK=(
  [format]="${GREEN}${BOLD}"
  [prefix]="ok: "
)
```

> [!NOTE]
> We recommend the use of the `LOG_STYLE_` prefix for style names.

## Roadmap

Here is a list of features I plan to implement:

- [x] Log functions that output on stdout
- [x] Diagnostics functions (errors, warnings, information and debug levels) that log on stderr
- [x] Style sheets with customizable formatting and colors
- [x] Conditionnaly display log levels based on an environment variable
- [ ] Optional script name display
- [ ] Optional script line display
- [ ] Execute function that can log the output of a command (behavior to be defined)
