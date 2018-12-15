#Bash variable scope

Global scope variables can be initialized or modified by functions. In cases where this is not desired, functions can avoid it using `local` variable 
definitions. In subshells, the situation is different: the new context receives a copy of the global scope variables but since it's a copy, any modification
only affect the variables in the scope of the subshell, not those in the global scope. A test script can be found in 
[tests/variable_scope.sh](tests/variable_scope.sh).

Global variables can also be set using:
```bash
printf -v $1 %s "$2"
```
or 
```bash
IFS="" read $1 <<< "$2"
```
Note that the `read` variant has problems if `$2` contains multiple lines. For details, have a look at this 
[StackOverflow question](https://stackoverflow.com/questions/9871458/declaring-global-variable-inside-a-function) 
