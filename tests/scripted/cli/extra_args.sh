EXPECTED="warning: ignored arguments: test.gabc
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information.
Proceeding anyway..."

OUTCOME=$($gregorio test.gabc test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
