# Bash misc
This repository groups all dev findings, snippets and tests related to the development of the [bash commons](https://github.com/DonTseTse/bash_commons).

## Reference documentation
- [Bash string extraction pattern details](documentation/string_variable_extraction.md) `${<string variable name>:<offset>:<length>}`
- [Problems with bash's associative arrays](documentation/array_existence_check_problem.md)

## Dev notes
- bash aliases are not adapted to create wrapper functions in libraries like the [bash commons](https://github.com/DonTseTse/bash_commons) because in 
  non-interactive mode their interpretation is usually disabled - aliases defined in the library might simply be ignored. It's safer to create "real" 
  functions, as it was done with [bash common's move_file()] f.ex. 
 
## Snippets
Get piped input:
```bash
[ -p /dev/stdin ] && echo "$(cat)"
```

Check if a command is defined:
```bash
[ -n "$(type -t "$command_name")" ]
```
It works for binaries, shell built-ins, (sourced) functions, etc. Unlike the one below, which works only for bash functions:
```bash
[ "$(type -t "$function_name")" = "function" ]
```
You can find these 3 snippets as functions in [snippet_functions.sh](snippet_functions.sh), with [documentation](snippet_functions.md).

Simplified script directory resolution (f.ex. in an installer before `bash_commons` are available):
```bash
# Exit with error message on file symlinks, set $script_folder to the directory in which the script is located (folder symlinks resolved)
symlink_error_msg="Error: Please don't call ... through file symlinks, this confuses the script about its own location. Call it directly. Aborting..."
if [ -h "${BASH_SOURCE[0]}" ]; then echo "$symlink_error_msg"; exit 1; fi
script_folder="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
```
**Important**: this code has to run before files are sourced, subshells are launched etc. because such operations affect `$BASH_SOURCE`
