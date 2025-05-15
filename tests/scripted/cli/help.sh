EXPECTED="Usage: $gregorio [OPTION]... [-s | INPUT_FILE]

Engrave Gregorian chant scores, convert a gabc file to GregorioTeX.

Options:
  -o, --output-file FILE    write output to FILE,
                            default is basename(INPUT_FILE).FORMAT
  -S, --stdout              write output to stdout
  -s, --stdin               read input from stdin
  -l, --messages-file FILE  output messages to FILE (default: stderr)
  -F, --output-format FORMAT
                            specify output format (default: gtex)
  -f, --input-format FORMAT
                            specify input format (default: gabc)
  -p, --point-and-click     generate Lilypond point and click information
  -h, --help                print this help message
  -V, --version             print version and exit
  -L, --license             print licence
  -v, --verbose             verbose mode
  -W, --all-warnings        output warnings
  -D, --deprecation-errors  treat deprecation warnings as errors
  -d, --debug               output debug information

Formats:
  gabc      gabc
  gtex      GregorioTeX
  dump      plain text dump (for debugging purpose)

See <http://gregorio-project.github.io/> for general documentation,
GregorioRef.pdf and GregorioNabcRef.pdf for full documentation."

OUTCOME=$(eval $gregorio -h)

[[ "$OUTCOME" == "$EXPECTED" ]] || exit 1
