# Project for Systematic Testing of Gregorio

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Test Types

This project provides a harness for repeatable testing of Gregorio.
Tests should be placed in the tests directory, within the proper
subdirectory depending on type.  The following types are supported:

#### gabc-gtex

This test runs gregorio against each gabc file in this directory to
produce a GregorioTeX file and compares it with an expected output file.

Requirements:

- Every gabc file must have a corresponding "expected" tex file.

Notes:

The first two lines are stripped from the "expected" tex file as well as
from the file produced by running gregorio during the test before the
comparison.

#### gabc-dump

This test runs gregorio against each gabc file in this directory to
produce an text dump file and compares it with an expected output file.

Requirements:

- Every gabc file must have a corresponding "expected" dump file.

#### gabc-output

This test creates a simple TeX driver file which invokes `\includescore`
on each gabc file in this directory in order to compile it and produce a
PDF, which is then compared with an expected PDF file.

Requirements:

- Every gabc file must have a corresponding "expected" PDF file.

Notes:

The PDFs are compared by first converting the pages to PNG files with
imagemagick's convert and then compared using imagemagick's compare and
the AE metric.

#### tex-output

This test runs lualatex on every tex file in this directory in order to
compile it and produce a PDF, which is then compared with an expected
PDF file.  It is recommended, due to the nature of this test, that each
test be in a separate subdirectory.

Requirements:

- Every tex file must have a corresponding "expected" PDF file.
- All other files needed by the tex file (i.e., gabc files) must also
  included

Notes:

The PDFs are compared by first converting the pages to PNG files with
imagemagick's convert and then compared using imagemagick's compare and
the AE metric.

## Creating "Expected" Files

For a new test:

1. Run `./gregorio-test.sh -n {subdirectory/under/tests}`
2. Run `./gregorio-test.sh -a {subdirectory/under/tests}`

For an existing test, where the new output is deemed to be correct.

1. Run `./gregorio-test.sh -a {subdirectory/under/tests}`

# Software Requirements

- Bash
- Imagemagick
- Gregorio
- TeX Live

# Developer Notes

To add a new kind of test, add a find function, a test function, and an
accept function to harness.sh.  Be sure to pass the prefix to the
register function after declaring the new functions.

All tests contributed must be licensed under GPLv3 with the "or later"
option.

# Copyright

```
Gregorio Tests
Copyright (C) 2015 Gregorio Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
```
