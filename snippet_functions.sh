#! /bin/bash

# Documentation: https://github.com/DonTseTse/bash_misc/snippet_functions.md#get_piped_input
function get_piped_input()
{
        [ -p /dev/stdin ] && echo "$(cat)"
}

# Documentation: https://github.com/DonTseTse/bash_misc/snippet_functions.md#is_command_defined
function is_command_defined()
{
        [ -n "$(type -t $1)" ]
}

# Documentation: https://github.com/DonTseTse/bash_misc/snippet_functions.md#is_function_defined
function is_function_defined()
{
        [ "$(type -t $1)" = "function" ]
}

# Documentation: https://github.com/DonTseTse/bash_commons/blob/master/helpers.md#set_global_variable
# Dev note: used to be done with $> IFS="" read $1 <<< "$2"  <$ but this created problems for multi-line $2
#           see https://stackoverflow.com/questions/9871458/declaring-global-variable-inside-a-function for details about this method
function set_global_variable()
{
        [ -z "$1" ] && return 1
        printf -v $1 %s "$2"
}
