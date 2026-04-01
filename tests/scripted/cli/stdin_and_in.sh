EXPECTED="warning: can't read from both stdin and a file, reading from test.gabc
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information.
Proceeding anyway..."

OUTCOME=$(eval $gregorio -s test.gabc 2>&1)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
