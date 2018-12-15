#! /bin/bash

. "../snippet_functions.sh"

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

echo "*** set_global_variable() ***"
echo "set_global_variable() is used in capture(), just checking the error case here"
configure_test 1 ""
test set_global_variable
