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
