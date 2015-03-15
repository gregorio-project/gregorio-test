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

if [ -d tests ]
then
	rm -fr output
	cp -r tests output

	for group in ${groups}
	do
		${group}_find | xargs -n 1 -0 -i bash -c "${group}_test"' "$@"' _ {} \;
	done
fi
