# bash-logger

**Simple and configurable logger library for Bash scripts**

> [!IMPORTANT]
> This project is under active development, see the [Roadmap](#roadmap) section below for more information.

**Bash logger** is a simple logger library to make the output of your Bash scripts friendlier for users.
It provides an easy-to-configure stylesheet to define various display styles which you can then use inside your scripts.

The stylesheet is pre-configured with the following default styles:

- Styles to display information or results
  - `NORMAL`: default white text with no formatting
  - `SECTION`: blue bold text for the main sections of a script
- Styles for diagnostics or when something goes wrong (log on the standard error):
  - `DEBUG`: dark text with a `debug:` prefix
  - `INFO`: white text woth an `info:` prefix 
  - `WARNING`: yellow text with a `warning:` prefix
  - `ERROR`: red text with an `error:` prefix

If you want to modify these styles or create your own, it is very easy to do so in the `styles.conf` file!

## Usage

1. Copy the `bash-logger.sh`, `formatting.conf` and `styles.conf` files to a directory in your project.
These three files must be in the same directory for the default configuration to work, but if you want to have a 
different file structure, you can modify the `FORMATSHEET_PATH` and the `STYLESHEET_PATH` variables in `bash-logger.sh`.

2. Source `bash-logger.sh` in your script:
```bash
. "$(dirname "${0}")"/path/to/bash-logger.sh
```

3. Use the predefined functions for one of the predefined styles or create your own:
```bash
# Use predefined styles
log "Welcome to my script!"
log_warning "x is not set"

# Use your own style
_log MY_STYLE "Hello with my style"
```

## Style creation

To create your style, edit the `styles.conf` file and create a new associative array with your configuration:

```bash
declare -r -A MY_STYLE=(
  [prefix]="my_style: " # Prefix that will be added before 
  [format]="${BOLD}${GREEN}" # Formatting options applied with this style, available in the formatting.conf file
  [script_name]=false # Should messages log with this style display the caller script's name (true or false)
  [log_level]=ANY # (optional) Messages will only be displayed if this level is enabled or above
  [stream]=1 # (optional) Output stream on which the message will be displayed (1: standard output, 2: standard error)
)
```

## Roadmap

Here is a list of features I plan to implement:

- [x] Simple log functions that output on stdout
- [x] Diagnostics functions (errors, warnings, information and debug levels) that log on stderr
- [x] Style sheets with customizable formatting and colors
- [x] Conditionnaly display log levels based on an environment variable
- [x] Optional script name display
- [ ] Optional script line display
- [ ] Execute function that can log the output of a command (behavior to be defined)
