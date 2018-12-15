#! /bin/bash

function change_pwd_function()
{
	local temp="$(mktemp -d)"
	cd "$temp"
	echo "cd in fct: \$> cd $temp"
}

echo "Current directory in script scope: \$(pwd) gives $(pwd)"

cd "/tmp"
echo "cd in script scope: \$> cd \"/tmp\""
echo "Current directory in script scope: \$(pwd) gives $(pwd)"

change_pwd_function
echo "Current directory in script scope: \$(pwd) gives $(pwd)"

echo "$(temp="$(mktemp -d)"; cd "$temp"; echo "cd in \$(...) subshell: \$> cd $temp")"
echo "Current directory in script scope: \$(pwd) gives $(pwd)"

(temp="$(mktemp -d)"; cd "$temp"; echo "cd in (...) subshell: \$> cd $temp")
echo "Current directory in script scope: \$(pwd) gives $(pwd)"

echo `temp="$(mktemp -d)"; cd "$temp"; echo "cd in '...' subshell: \$> cd $temp"`
echo "Current directory in script scope: \$(pwd) gives $(pwd)"
