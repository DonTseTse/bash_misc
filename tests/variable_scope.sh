#! /bin/bash

var="global scope"
echo "var=\"global scope\""

function fct()
{
	echo "\$var in fct(): $var"
}

function fct_w_local()
{
        echo "\$var in fct_w_local(): $var"
	local var="function scope"
	echo "in fct_w_local() \$> local var=\"function scope\""
        echo "\$var in fct_w_local(): $var"
}

function modify_var()
{
	var="modified in modify_var()"
	echo "in modify_var() \$> var=\"modified in modify_var()\""
        echo "\$var in modify_var(): $var"
}

function define_var()
{
	defined_by_fct="defined in define_var()"
	echo "in define_var(): \$> defined_by_fct=\"defined in define_var()\""
	local local_defined_by_fct="defined as local in define_var()"
	echo "in define_var(): \$> local local_defined_by_fct=\"defined as local in define_var()\""
}

echo "\$var on global scope: $var"
fct
echo "\$var on global scope: $var"
fct_w_local
echo "\$var on global scope: $var"
modify_var
echo "\$var on global scope: $var"
var="global scope"
echo "var=\"global scope\""
echo "in \$() subshell: $(echo $var)"
echo "$(var="modified in \$() subshell"; echo "in \$() subshell: \$> var=\"modified in \$() subshell\""; echo "\$var in \$() subshell: $var")"
echo "\$var on global scope: $var"
(var="modified in () subshell"; echo "in \$() subshell: \$> var=\"modified in () subshell\""; echo "\$var in () subshell: $var")
echo "\$var on global scope: $var"
echo "`var="modified in backticks subshell"; echo "in backticks subshell: \$> var=\"modified in backticks subshell\""; echo "\\$var in backticks subshell: $var"`"
echo "\$var on global scope: $var"
define_var
echo "\$defined_by_fct on global level: \"$defined_by_fct\""
echo "\$local_defined_by_fct on global level: \"$local_defined_by_fct\""
