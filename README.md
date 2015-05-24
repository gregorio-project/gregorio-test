# Project for Systematic Testing of Gregorio

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Running the test suite

Use `./gregorio-test.sh` to run the full test suite with default options.
Pass the name(s) of desired tests to run those tests specifically.  Pass the
`-h` option to get a summary of available options.

`gregorio-test.sh` will read a `gregorio-test.rc` file, if it exists, to set
up some features such as color.  Please read the `gregorio-test.sh` file
itself for more information.  See `example.gregorio-test.rc` for an example.

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
test be in a separate subdirectory.  Unless necessary for a particular
test, use the provided Alegreya fonts for rendering.

Requirements:

- Every tex file must have a corresponding "expected" PDF file.
- All other files needed by the tex file (i.e., gabc files) must also
  be included.
- Use of the provided Alegreya fonts is recommended.

Notes:

The PDFs are compared by first converting the pages to PNG files with
imagemagick's convert and then compared using imagemagick's compare and
the AE metric.

#### plain-tex

The plain TeX version of `tex-output`.  This test runs luatex on every
tex file in this directory in order to compile it and produce a PDF,
which is then compared with an expected PDF file.  It is recommended,
due to the nature of this test, that each test be in a separate
subdirectory.  Unless necessary for a particular test, use the provided
Alegreya fonts for rendering.

Requirements:

- Every tex file must have a corresponding "expected" PDF file.
- All other files needed by the tex file (i.e., gabc files) must also
  be included.
- Use of the provided Alegreya fonts is recommended.

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

Each kind of test must have seven functions defined in `harness.sh`, prefixed
by a common prefix:

- find
- test
- accept
- view\_log
- view\_diff
- view\_expected
- view\_output

Be sure to pass the prefix to the register function after declaring the new
functions.

All tests contributed must be licensed under GPLv3 with the "or later"
option.

Put comments in test cases to describe what they test.  They are
free-form for now, but start the comment with `%issue:` to give the
GitHub issue number and with `%notes:` to summarize the test case.
Such magic comments may be harvested in the future.

# Copyright

```
Gregorio Tests
Copyright (C) 2015 The Gregorio Project

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
```

The Alegreya fonts in the `fonts` directory are bundled with these
tests in order to set a reasonably complete, stable font for the
majority of the PDF-based tests.  These fonts are Copyright (C) 2011,
Juan Pablo del Peral, and are licensed under the SIL Open Font License.
See the `SIL Open Font License.txt` file in the `fonts` directory for
details.
