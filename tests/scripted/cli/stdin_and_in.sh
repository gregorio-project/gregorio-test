EXPECTED="warning: can't read from both stdin and a file, reading from test.gabc
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information.
Proceeding anyway..."

OUTCOME=$("$gregorio_path" -s test.gabc 2>&1 | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
