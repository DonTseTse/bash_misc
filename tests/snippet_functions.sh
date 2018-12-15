#! /bin/bash

if [ -h "${BASH_SOURCE[0]}" ]; then echo "Error: called through symlink. Please call directly. Aborting..."; exit 1; fi
functions_path="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && dirname "$(pwd)")"

. "$functions_path/snippet_functions.sh"

function fct()
{
	return $?
}

echo "[Note] defined function fct()"
echo "\$> which tail $(which tail)"
is_command_defined "tail"
echo "is_command_defined \"tail\" returns $?"

is_function_defined "fct"
echo "is_function_defined \"fct\" returns $?"
is_function_defined "tail"
echo "is_function_defined \"tail\" returns $?"

echo "*** get_piped_input() ***"
output="$(echo "test piped input" | get_piped_input)"
echo "\$(echo \"test piped input\" | get_piped_input) writes \"$output\" on stdout"
