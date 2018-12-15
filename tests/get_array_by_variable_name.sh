#! /bin/bash

arr=("1st" "2nd" "3rd")
array_variable_name="arr"
index=1
echo "\$> arr=(\"1st\" \"2nd\" \"3rd\") array_variable_name=$array_variable_name index=$index"
echo "[Note] Whatever is tried, it seems impossible to use the bash's array expansion syntax when the variable name is itself a variable"
echo "\${!array_variable_name}: ${!array_variable_name}"
echo "\${!array_variable_name[\$index]}: ${!array_variable_name[$index]}"
echo "\${array_variable_name[\$index]}: ${array_variable_name[$index]}"
printf "\${$array_variable_name[1]}: "
echo "${$array_variable_name[1]}"
printf "\${{\$array_variable_name}[\$index]}: "
echo "${{$array_variable_name}[$index]}"
printf "\${{!\$array_variable_name}[\$index]}: "
echo "${{!$array_variable_name}[$index]}"
printf "\${{!array_variable_name}[\$index]}: "
echo "${{!array_variable_name}[$index]}"
echo "[Note] At the end, the eval solution is the only one that works"
printf "eval \"echo \${$array_variable_name[$index]}\": "
eval "echo \${$array_variable_name[$index]}"
