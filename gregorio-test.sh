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

cd "$(dirname "${BASH_SOURCE[0]}")"

source harness.sh

export GREGORIO=${GREGORIO:-gregorio}

if [ ! -d tests ]
then
	echo "No tests to run."
	exit 1
fi

rm -fr output
cp -r tests output

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
