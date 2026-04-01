EXPECTED="warning: deprecation-errors option passed several times
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information.
Proceeding anyway..."

OUTCOME=$(eval $gregorio -D -D test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
