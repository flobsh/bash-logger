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

## Roadmap

Here is a list of features I plan to implement:

- [x] Simple log functions that output on stdout
- [x] Diagnostics functions (errors, warnings, information and debug levels) that log on stderr
- [x] Style sheets with customizable formatting and colors
- [x] Conditionnaly display log levels based on an environment variable
- [x] Optional script name display
- [ ] Optional script line display
- [ ] Execute function that can log the output of a command (behavior to be defined)
