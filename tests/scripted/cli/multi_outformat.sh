EXPECTED="warning: several output formats declared, first taken
warning: several output formats declared, first taken
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information.
Proceeding anyway...
error: refusing to overwrite the input file"

OUTCOME=$("$gregorio_path" -F gabc -F dump -F gtex test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
