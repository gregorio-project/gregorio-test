EXPECTED="warning: ignored arguments: test.gabc
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information.
Proceeding anyway..."

OUTCOME=$($gregorio test.gabc test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
