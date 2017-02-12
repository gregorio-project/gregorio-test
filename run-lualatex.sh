#!/usr/bin/env bash

# Gregorio Tests - Script for lualatex processing
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

# This script allows lualatex to be run with more control.

CP="${CP:-cp}"

output="$1"
shift
lualatex --shell-escape --debug-format --interaction=nonstopmode --halt-on-error --file-line-error "$@"
#"$CP" --preserve=timestamps --backup=numbered "$output" "${output%.pdf}.backup.pdf"
#"$CP" --preserve=timestamps --backup=numbered "${output%.pdf}.log" "${output%.pdf}.backup.log"
