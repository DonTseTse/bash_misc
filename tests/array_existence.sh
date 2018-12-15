#! /bin/bash

integer_var=2
string_var="string"
numeric_array_var=("1st" "2nd")
declare -A associative_array_var && associative_array_var[index]="value"

echo "[Note] 4 variables declared"
echo "\$> integer_var=$integer_var; string_var=\"$string_var\"; numeric_array_var=(\"${numeric_array_var[0]}\" \"${numeric_array_var[1]}\");"
echo "\$> declare -A associative_array_var && associative_array_var[index]=\"${associative_array_var[index]}\""

[ -v "unknown" ]
echo "[ -v \"unknown\" ] returns $?"
[ -v "integer_var" ]
echo "[ -v \"integer_var\" ] returns $?"
[ -v "string_var" ]
echo "[ -v \"string_var\" ] returns $?"
[ -v "numeric_array_var" ]
echo "[ -v \"numeric_array_var\" ] returns $?"
[ -v "associative_array_var" ]
echo "[ -v \"associative_array_var\" ] returns $?"
[ -v "${associative_array_var}" ]
echo "[ -v \"\${associative_array_var}\" ] returns $?"
echo "[Note] Problem: for the associative array the -v <variable name> check doesn't work ***"
[ -n "$unknown" ]
echo "[[ -n \"\$unknown\" ]] returns $?"
[ -n "$integer_var" ]
echo "[[ -n \"\$integer_var\" ]] returns $?"
[ -n "$string_var" ]
echo "[[ -n \"\$string_var\" ]] returns $?"
[ -n "$numeric_array_var" ]
echo "[[ -n \"\$numeric_array_var\" ]] returns $?"
[ -n "$associative_array_var" ]
echo "[[ -n \"\$associative_array_var\" ]] returns $?"
[ -n "${associative_array_var}" ]
echo "[[ -n \"\${associative_array_var}\" ]] returns $?"
echo "[Note] Same problem for -n <variable> ***"
echo "[Note] A few other things were tried but they are commented out because they lead to errors."
echo "[Note] see https://github.com/DonTseTse/bash_misc/README.md  or look at the source"
# Frustration that nothing works... just to try
#[ -v "${associative_array_var[*]}" ]
#echo "[ -v \"\${associative_array_var[*]}\" ] returns $?"
#[ -v "${associative_array_var[@]}" ]
#echo "[ -v \"\${associative_array_var[@]}\" ] returns $?"
# Pattern ${<variable name>:?<fallback>} used below produces errors
#stdout="$([ ! ${associative_array_var :?"___variable_empty___"} = "___variable_empty___" ])"
#echo "[ ! \"\${associative_array_var?\"___variable_empty___\"}\" = \"___variable_empty___\" ] returns $?"
#echo "Stdout: $stdout"
echo "[Note] The \"solution\":"
[ -v "unknown" ] || [ "${#unknown[*]}" -gt 0 ]
echo "[ -v \"unknown\" ] || [ \"\${#unknown[*]}\" -gt 0 ] returns $?"
[ -v "integer_var" ] || [ "${#integer_var[*]}" -gt 0 ]
echo "[ -v \"integer_var\" ] || [ \"\${#integer_var[*]}\" -gt 0 ] returns $?"
[ -v "string_var" ] || [ "${#string_var[*]}" -gt 0 ]
echo "[ -v \"string_var\" ] || [ \"\${#string_var[*]}\" -gt 0 ] returns $?"
[ -v "numeric_array_var" ] || [ "${#numeric_array_var[*]}" -gt 0 ]
echo "[ -v \"numeric_array_var\" ] || [ \"\${#numeric_array_var[*]}\" -gt 0 ] returns $?"
[ -v "associative_array_var" ] || [ "${#associative_array_var[*]}" -gt 0 ]
echo "[ -v \"associative_array_var\" ] || [ \"\${#associative_array_var[*]}\" -gt 0 ] returns $?"

