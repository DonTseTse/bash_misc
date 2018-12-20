# Array problems

Arrays or commands involving arrays have sometimes an unexpected behavior depending on the array type:
- the usual "is variable defined?" check doesn't work for associative arrays
- the attempt to load a non-numeric index in a numeric array raises no error and returns a value.  
  As a consequence, a reliable universal "does the array have an element at index x?" check can't be based 
  on the fact whether a value is returned or not 

### "Is variable defined?" problem
The usual "does variable exist" syntax snippets don't work with associative arrays.

Take the `[ -v <variable name> ]` pattern for example ([details](https://stackoverflow.com/questions/30749421/how-can-i-check-if-an-associative-array-element-exists-in-my-bash-script/30750380)):
```bash
integer_var=2
string_var="string"
numeric_array_var=("1st" "2nd")
declare -A associative_array_var && associative_array_var[index]="value"
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
```
It prints:
```
[ -v "unknown" ] returns 1
[ -v "integer_var" ] returns 0
[ -v "string_var" ] returns 0
[ -v "numeric_array_var" ] returns 0
[ -v "associative_array_var" ] returns 1
[ -v "${associative_array_var}" ] returns 1
```

Many examples given on the web don't work in this case:
- the `[ -n <variable> ]` pattern, which gives the same result as `[ -v <variable name> ]` shown in the example above
- the `${<variable name>:?<fallback>}` pattern ([details](https://bash.cyberciti.biz/guide/Bash_variable_existence_check))which fails for arrays

One solution is the pattern 
```bash
[ -v <variable name> ] || [ "${#<variable name>[*]}" -gt 0 ]
```
It doesn't produce errors and returns the expected status (continuation from above, supposing identical variable definitions):
```
[ -v "unknown" ] || [ "${#unknown[*]}" -gt 0 ] returns 1
[ -v "integer_var" ] || [ "${#integer_var[*]}" -gt 0 ] returns 0
[ -v "string_var" ] || [ "${#string_var[*]}" -gt 0 ] returns 0
[ -v "numeric_array_var" ] || [ "${#numeric_array_var[*]}" -gt 0 ] returns 0
[ -v "associative_array_var" ] || [ "${#associative_array_var[*]}" -gt 0 ] returns 0
```
With one restriction however: since it uses a check for the number of elements of an eventual array, it returns with status *1* if
the array is declared but empty. 

### "Does the array have an element at index *x* ?" problem
The snippet
```bash
numeric_array_var=("1st" "2nd")
echo " \$> numeric_array_var=(\"1st\" \"2nd\")"
declare -A associative_array_var && associative_array_var[index]="value"
echo " \$> declare -A associative_array_var && associative_array_var[index]=\"${associative_array_var[index]}\""
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
```
prints
```
 $> numeric_array_var=("1st" "2nd")
 $> declare -A associative_array_var && associative_array_var[index]="value"
[ -n "${numeric_array_var[0]}" ] returns 0
[ -n "${numeric_array_var[100]}" ] returns 1
[ -n "${numeric_array_var[string]}" ] returns 0
[ -n "${associative_array_var[index]}" ] returns 0
[ -n "${associative_array_var[undefined]}" ] returns 1
[ -n "${associative_array_var[0]}" ] returns 1
```
The expansion syntax returns a value if a non-numeric index is used in a numeric array. The pattern `${<variable name>[<index>]-<placeholder>}` 
also gives unconclusive results (supposing the same variable definitions as above):
```
Numeric array element 0: ${numeric_array_var[0]} gives '1st' - ${numeric_array_var[0]-foo} gives '1st'
Numeric array element 100 (not defined): ${numeric_array_var[100]} gives '' - ${numeric_array_var[100]-foo} gives 'foo'
Numeric array element 'string' (not defined): ${numeric_array_var[string]} gives '1st' - ${numeric_array_var[string]-foo} gives '1st'
Associative array element 'index': ${associative_array_var[index]} gives 'value' - ${associative_array_var[index]-foo} gives 'value'
Associative array element 'undefined' (not defined): ${associative_array_var[undefined]} gives '' - ${associative_array_var[undefined]-foo} gives 'foo'
Associative array element 0 (not defined): ${associative_array_var[0]} gives '' - ${associative_array_var[0]-foo} gives 'foo'
``` 
Finally, a solution based on a `grep` over the expanded array indizes was implemented in [bash commons' 
is_array_index()](https://github.com/DonTseTse/bash_commons/blob/master/helpers.md#is_array_index) 
