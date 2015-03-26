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

usage=false
verify=true
accept=false
while getopts ":ag:hn" opt
do
	case $opt in
		a)
			accept=true
			;;
		g)
			gregorio_dir="$(realpath "$OPTARG")"
			;;
		h)
			usage=true
			;;
		n)
			verify=false
			;;
		\?)
			echo "Unknown option: -$OPTARG" >&2
			echo "(use $0 -h for help)" >&2
			exit 1
			;;
		:)
			echo "Option -$OPTARG is missing its required argument." >&2
			echo "(use $0 -h for help)" >&2
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

if $usage
then
	columns=$(stty size | cut -d' ' -f2)
	(( columns = columns - 5 ))
	if (( columns < 50 ))
	then
		columns=50
	fi
	fmt -sw $columns <<EOT
Usage: $0 [OPTION]... [TEST]...

Runs the Gregorio test suite.  If no TEST is specified, all tests will run.

Options:

  -g GREGORIO_DIR   specifies the directory containing a not-installed
                    version of Gregorio.  For this script to be able to use
                    a not-installed Gregorio, the gregorio executable must
                    be linked statically.

  -n                runs the tests without verifying results.  Useful (in
                    conjunction with -a) for generating the initial result
                    of a new test to use as future expectation.

  -a                accepts the result of each given TEST.  Must be run
                    after the tests are run.  Makes the result into the
                    future expectation.  Requires that at least one TEST be
                    specified.  Don't forget to add/commit the change!

  -h                shows this usage message.
EOT
	exit 1
fi

export verify

export testroot="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
cd "$testroot"

source harness.sh

if [ ! -d tests ]
then
	echo "No tests to run."
	exit 1
fi

if [ "$1" = "" ]
then
	if $accept
	then
		echo "At least one TEST to accept must be specified." >&2
		echo "(use $0 -h for help)" >&2
		exit 4
	fi

	function filter {
		while read line
		do
			echo $line
		done
	}
else
	declare -A tests_to_run
	while [ "$1" != "" ]
	do
		tests_to_run[$1]=1
		shift
	done

	function filter {
		while read line
		do
			if [ "${tests_to_run[$line]}" = "1" ]
			then
				echo $line
			fi
		done
	}
fi

if $accept
then
	cd output
	for group in ${groups}
	do
		${group}_find | filter | xargs -n 1 -i bash -c "${group}_accept"' "$@"' _ {} \;
	done
else
	rm -fr output
	cp -r tests output

	if [ "$gregorio_dir" != "" ]
	then
		if [ ! -f "$gregorio_dir/src/gregorio" -o ! -x "$gregorio_dir/src/gregorio" ]
		then
			echo "$gregorio_dir/src/gregorio is not an executable" >&2
			exit 2
		fi

		echo "Preparing to use Gregorio from $gregorio_dir"

		export PATH="$gregorio_dir/src:$PATH"

		mkdir output/texmf
		export output_texmf=$(realpath output/texmf)

		if ! (cd "$gregorio_dir" && TEXHASH="texhash $output_texmf" ./install-gtex.sh "dir:$output_texmf")
		then
			echo "Unable to install GregorioTeX to $output_texmf" >&2
			exit 2
		fi

		TEXMF="$(kpsewhich --var-value TEXMF)"
		TEXMF="${TEXMF/{/{$output_texmf,}"
		export TEXMF

		echo
	fi

	if ! gregorio -F dump -S -s </dev/null 2>/dev/null | grep -q 'SCORE INFOS'
	then
		echo "Gregorio is not installed properly or is not statically linked" >&2
		echo "When building, use ./configure --enable-all-static" >&2
		exit 3
	fi

	echo "Gregorio = $(which gregorio)"
	echo "GregorioTeX = $(kpsewhich gregoriotex.tex)"
	echo

	processors=$(nproc 2>/dev/null || echo 1)
	overall_result=0
	cd output
	for group in ${groups}
	do
		if ! ${group}_find | filter | xargs -P $processors -n 1 -i bash -c "${group}_test"' "$@"' _ {} \;
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
fi
exit 0
