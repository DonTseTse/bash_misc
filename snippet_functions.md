Documentation for the functions in (snippet_functions.sh).
## Quick access
- [get_piped_input()](#get_piped_input)
- [is_command_defined()](#is_command_defined)
- [is_function_defined()](#is_function_defined)

## Function documentation
If the pipes are not documented, the default is:
- `stdin`: piped input ignored
- `stdout`: empty

Parameters enclosed in brackets [ ] are optional.

### is_command_defined()
Returns with status *0* if the shell has a "definition" for the command `$1`, regardless what type it is (function, built-in,
file, etc.). It's similar to `which` but may also be used for bash functions and helps avoid "command ... unknown" errors. It
may be used in instruction chains:

        is_command_defined "tail" && tail "..."
will only call `tail` if it's defined (aka installed). The example shows an essential difference with
<a href="#is_function_defined">is_function_defined()</a> which will always return status *1* (not defined) for `tail` because it
has the type *file*, not *function*.
<table>
        <tr><td><b>Param.</b></td><td align="center"><code>$1</code></td><td width="90%">name of the function</td></tr>
        <tr><td rowspan="2"><b>Status</b></td>
                <td align="center"><em>0</em></td><td>function <code>$1</code> is defined</td></tr>
        <tr>    <td align="center"><em>1</em></td><td>function <code>$1</code> is not defined</td></tr>
</table>

### is_function_defined()
Returns with status *0* if a bash function with the name `$1` exists. Useful to avoid "command ... unknown" errors.

**Important**: do not use this function to check for the availability of standard shell utilities like `echo` or `tail` f.ex. - these
are not considered functions by bash (types *builtin* and *file*, respectively). Even if they are defined, this function returns
status *1* (not defined) - use <a href="#is_command_defined">is_command_defined()</a> instead.

Example of the use in an instruction chain:

        is_function_defined "log" && log "..."
will only call `log` if it's defined.
<table>
        <tr><td><b>Param.</b></td><td align="center"><code>$1</code></td><td width="90%">name of the function</td></tr>
        <tr><td rowspan="2"><b>Status</b></td>
                <td align="center"><em>0</em></td><td>function <code>$1</code> is defined</td></tr>
        <tr>    <td align="center"><em>1</em></td><td>function <code>$1</code> is not defined</td></tr>
</table>

### get_piped_input()
Returns the piped `stdin` content on `stdout`, which allows to capture it into a variable, here f.ex. to `$input`:

        input="$(get_piped_input)"
<table>
        <tr><td rowspan="2"><b>Pipes</b></td>
                <td align="center"><code>stdin</code></td><td width="90%">read completely</td></tr>
        <tr>    <td align="center"><code>stdout</code></td><td>copy of <code>stdin</code>'s piped input</td></tr>
        <tr><td><b>Status</b></td><td align="center"><em>0</em></td><td></td></tr>
</table>
