#!/usr/bin/env bash

# Gregorio Tests - Review Script
# Copyright (C) 2016 The Gregorio Project
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

# This script uses gregorio-test.sh to interactively review the results
# of the previously run test.

IFS=$'\n' array=($(find output -name '*.result' -exec cat {} +))
for line in ${array[*]}
do
    IFS='|' read result filename category <<<$line
    if [ "$result" = "FAIL" ]
    then
        action="-d"
        while :
        do
            ./gregorio-test.sh $action "$filename"
            echo -n "accept ($category) $filename [y/n/e/v/d/l]? "
            read answer
            case "$answer" in
                y)
                    ./gregorio-test.sh -a "$filename"
                    break
                    ;;
                n)
                    break
                    ;;
                e)
                    action="-e"
                    ;;
                v)
                    action="-v"
                    ;;
                d)
                    action="-d"
                    ;;
                l)
                    action="-l"
                    ;;
                *)
                    echo "Invalid choice"
                    action="-d"
                    ;;
            esac
        done
    fi
done
