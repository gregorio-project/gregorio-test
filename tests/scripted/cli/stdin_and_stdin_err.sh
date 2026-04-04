EXPECTED="warning: option used several times: s
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information.
Proceeding anyway..."

OUTCOME=$(cat test.gabc | "$gregorio_path" -s -s 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
