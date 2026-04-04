EXPECTED="warning: several output formats declared, first taken
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information.
Proceeding anyway..."

OUTCOME=$("$gregorio_path" -f gabc -f gabc test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
