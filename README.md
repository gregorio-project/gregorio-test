# PROJECT FOR SYSTEMATIC TESTING OF GREGORIO

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

This project provides a harness for repeatable testing of Gregorio.
Tests should be placed in the tests directory, within the proper
subdirectory depending on type.  The following types are supported:

## gabc-gtex

This test runs gregorio against each gabc file in this directory to
produce a GregorioTeX file and compares it with an expected output file.

Requirements:

- Every gabc file must have a corresponding "expected" tex file.  This
  file can be created by running `gregorio -f gtex <gabc-file>`

Notes:

The first two lines are stripped from the "expected" tex file as well as
from the file produced by running gregorio during the test before the
comparison.

## gabc-dump

This test runs gregorio against each gabc file in this directory to
produce an text dump file and compares it with an expected output file.

Requirements:

- Every gabc file must have a corresponding "expected" dump file.  This
  file can be created by running `gregorio -f dump <gabc-file>`

## gabc-output

This test creates a simple TeX driver file which invokes `\includescore`
on each gabc file in this directory in order to compile it and produce a
PDF, which is then compared with an expected PDF file.

Requirements:

- Every gabc file must have a corresponding "expected" PDF file.  This
  file can be created by running lualatex `--shell-escape <tex-file>`
  where `<tex-file>` is a copy of the heredoc file in harness.sh with the
  `<gabc-file>` substituted.

Notes:

The PDFs are compared by first converting the pages to PNG files with
imagemagick's convert and then compared using imagemagick's compare and
the AE metric.

%% tex-output

This test runs lualatex on every tex file in this directory in order to
compile it and produce a PDF, which is then compared with an expected
PDF file.  It is recommended, due to the nature of this test, that each
test be in a separate subdirectory.

Requirements:

- Every tex file must have a corresponding "expected" PDF file.  This
  file can be created by running `lualatex --shell-escape <tex-file>`
- All other files needed by the tex file (i.e., gabc files) must also
  included

Notes:

The PDFs are compared by first converting the pages to PNG files with
imagemagick's convert and then compared using imagemagick's compare and
the AE metric.

# SOFTWARE REQUIREMENTS

- Bash
- Imagemagick
- Gregorio (installed)


# DEVELOPER NOTES

To add a new kind of test, add a find function and a test function to
harness.sh.  Be sure to add the prefix to the "groups" variable and to
"export -f" the test function.

All tests contributed must be licensed under GPLv3.

I hope to add parallel execution once we have enough tests to make it
worthwhile.


# COPYRIGHT

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
