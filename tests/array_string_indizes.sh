#! /bin/bash

numeric_array_var=("1st" "2nd")
echo "\$> numeric_array_var=(\"1st\" \"2nd\")"
declare -A associative_array_var && associative_array_var[index]="value"
echo "\$> declare -A associative_array_var && associative_array_var[index]=\"${associative_array_var[index]}\""
[ -n "${numeric_array_var[0]}" ]
echo "[ -n \"\${numeric_array_var[0]}\" ] returns $?"
[ -n "${numeric_array_var[100]}" ]
echo "[ -n \"\${numeric_array_var[100]}\" ] returns $?"
[ -n "${numeric_array_var[string]}" ]
echo "[ -n \"\${numeric_array_var[string]}\" ] returns $?"
[ -n "${associative_array_var[index]}" ]
echo "[ -n \"\${associative_array_var[index]}\" ] returns $?"
[ -n "${associative_array_var[undefined]}" ]
echo "[ -n \"\${associative_array_var[undefined]}\" ] returns $?"
[ -n "${associative_array_var[0]}" ]
echo "[ -n \"\${associative_array_var[0]}\" ] returns $?"

function check_expansion_syntax()
{
	printf -v var_snippet '${%s[%s]}' "$1" "$2"
	printf -v var_check_snippet '${%s[%s]-foo}' "$1" "$2"
	local var="$(eval "echo $var_snippet")"
	local counter_check_var="$(eval "echo $var_check_snippet")"
	echo "$var_snippet gives '$var' - $var_check_snippet gives '$counter_check_var'"
}

echo "Numeric array element 0: $(check_expansion_syntax "numeric_array_var" 0)"
echo "Numeric array element 100 (not defined): $(check_expansion_syntax "numeric_array_var" 100)"
echo "Numeric array element 'string' (not defined): $(check_expansion_syntax "numeric_array_var" "string")"
echo "Associative array element 'index': $(check_expansion_syntax "associative_array_var" "index")"
echo "Associative array element 'undefined' (not defined): $(check_expansion_syntax "associative_array_var" "undefined")"
echo "Associative array element 0 (not defined): $(check_expansion_syntax "associative_array_var" 0)"
