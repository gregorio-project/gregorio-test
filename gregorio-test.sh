#!/bin/bash

# Gregorio Tests
# Copyright (C) 2015 Gregorio Team
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

while getopts ":g:h" opt
do
	case $opt in
		g)
			gregorio_dir="$(realpath "$OPTARG")"
			;;
		:)
			echo "Option -$OPTARG requires an argument." >&2
			;;
		h)
			usage=1
			;;
		\?)
			echo "Invalid option: -$OPTARG." >&2
			usage=1
			;;
	esac
done

if [ "$usage" = "1" ]
then
	echo "Usage: $0 [-g gregorio_dir] [-h]"
	exit 1
fi

cd "$(dirname "${BASH_SOURCE[0]}")"

source harness.sh

if [ ! -d tests ]
then
	echo "No tests to run."
	exit 1
fi

rm -fr output
cp -r tests output

if [ "$gregorio_dir" != "" ]
then
	if [ ! -f "$gregorio_dir/src/gregorio" -o ! -x "$gregorio_dir/src/gregorio" ]
	then
		echo "$gregorio_dir/src/gregorio is not an executable" >&2
		exit 2
	fi
	export PATH="$gregorio_dir/src:$PATH"
	export TEXINPUTS=".:$gregorio_dir/tex:"
fi

if ! gregorio -F dump -S -s </dev/null 2>/dev/null | grep -q 'SCORE INFOS'
then
	echo "Gregorio is not installed properly or is not statically linked" >&2
	echo "use ./configure --enable-all-static" >&2
	exit 3
fi

echo "Gregorio = $(which gregorio)"
echo "GregorioTeX = $(kpsewhich gregoriotex.tex)"
echo

processors=$(nproc 2>/dev/null || echo 1)
overall_result=0
for group in ${groups}
do
	if ! ${group}_find | xargs -P $processors -n 1 -0 -i bash -c "${group}_test"' "$@"' _ {} \;
	then
		overall_result=1
	fi
done

echo

if [ ${overall_result} != 0 ]
then
	echo "SOMETHING FAILED"
	exit 1
fi

echo "ALL PASS"
exit 0
