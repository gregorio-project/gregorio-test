EXPECTED="error: unknown input format: bad
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information."

OUTCOME=$("$gregorio_path" -f bad test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
